import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:the_apple_sign_in/the_apple_sign_in.dart' as apple_sign_in;
import 'package:veda_nidhi_v2/main.dart';
import '../models/refresh_response_model.dart';
import '../utils/constants.dart';
import '../utils/converter_utils.dart';
import '../utils/shared_prefs.dart';
import '../views/otp_view/otp_view_screen.dart';
import '../widgets/snackbars.dart';
import 'error_status_controller.dart';

class AuthServiceController extends GetxController {
  final _dio = Dio();
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  final _errorController = Get.find<ErrorStatusController>();
  RxBool isLoggedIn = false.obs;
  Rx<String?> accessToken = ''.obs;
  Rx<String?> refreshToken = ''.obs;
  final _auth = FirebaseAuth.instance;
  bool? userfound;
  String verificationID = '';
  int? resendToken;
  RxString failedText = "".obs;
  RxBool signUpLoader = false.obs;
  // final localDb = LocalDb();
  bool get isUserLoggedin => isLoggedIn.value;

  Future<bool> checkLoginStatus() async {
    isLoggedIn.value = await SharedPref.isUserLoggedIn();
    if (isLoggedIn.value) {
      accessToken.value = await SharedPref.getAccessToken();
      refreshToken.value = await SharedPref.getRefreshToken();

      if (JwtDecoder.isExpired(accessToken.value!)) {
        await getNewTokens();
      }
    } else {
      accessToken.value = '';
      refreshToken.value = '';
    }
    return isLoggedIn.value;
  }

  Future<void> phoneNumberVerification(
      {required String phoneNumber, required String countryCode}) async {
    switchSignupLoader(true);
    await _auth.verifyPhoneNumber(
      phoneNumber: countryCode + phoneNumber.trim(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        failedText.value = "";
      },
      verificationFailed: (FirebaseAuthException e) {
        verificationID = '';
        failedText.value = "Verification failed. Please try again";
        switchSignupLoader(false);
      },
      codeSent: (String verificationId, int? resToken) async {
        switchSignupLoader(false);
        _errorController.clearError();
        verificationID = verificationId;
        resendToken = resToken;
        Get.to(() => OtpViewScreen(
              phoneNumber: phoneNumber,
              code: countryCode,
            ));
        Get.snackbar('Code Sent', 'A Code has been sent to your number');
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        switchSignupLoader(false);
        verificationID = verificationId;
      },
      timeout: const Duration(seconds: 30),
      forceResendingToken: resendToken,
    );
  }

  Future signIn({required String smsCode, required String phoneNumber}) async {
    try {
     
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: smsCode);
  

      var result = await _auth.signInWithCredential(credential);
    

      User? user = result.user;
    

      if (user != null) {
        
        _errorController.clearError();
        bool userFound =
            await isUserFound(ConverterUtils.getEmail(user.phoneNumber!));
        
        if (userFound) {
          await SharedPref.setNewUser(false);
          await loginUser(
              phoneNumber: phoneNumber,
              isGoogleAuth: false,
              isAppleAuth: false);
        } else {
          await SharedPref.setNewUser(true);
          await _createUser(
              user: user, isGoogleAuth: false, isAppleAuth: false);
        }
        Get.back();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-verification-code') {
        _errorController.setError("Verification Failed. Please try again");
      }
    } catch (e) {
      showErrorFromCatch("Error 88", "Unknown Error Occured");
    }
  }

  Future reSendOTP(
      {required String phoneNumber, required String countryCode}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: countryCode + phoneNumber.trim(),
      verificationCompleted: (PhoneAuthCredential credential) {
        failedText.value = "";
      },
      verificationFailed: (FirebaseAuthException e) {
        verificationID = '';
        failedText.value = "Verification failed. Please try again";
      },
      codeSent: (String verificationId, int? resToken) async {
        _errorController.clearError();
        verificationID = verificationId;
        resendToken = resToken;
        Get.snackbar('Code Sent', 'A Code has been sent to your number');
      },
      timeout: const Duration(seconds: 30),
      forceResendingToken: resendToken,
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationID = verificationId;
      },
    );
  }

  Future<bool> getNewTokens() async {
    try {
      var response = await _dio.post(
        '$baseUrl/auth/refresh',
        data: {
          "refresh_token": refreshToken.value,
        },
      );

      if (response.statusCode == 200) {
        final refreshTokenResponse =
            refreshTokenResponseFromMap(response.toString());
        await updateRefreshToken(refreshTokenResponse.data.refreshToken);
        await updateAccessToken(refreshTokenResponse.data.accessToken);

        return true;
      }
    } on DioError catch (e) {
      await signOut();
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  Future _createUser(
      {required User user,
      required bool isGoogleAuth,
      required bool isAppleAuth}) async {
    final deviceToken = await SharedPref.getDeviceToken();
    if (deviceToken == null) {
      final newDeviceToken = await firebaseMessaging.getToken();
      if (newDeviceToken != null) {
        await SharedPref.setDeviceToken(newDeviceToken);
      }
    }
    // print(isGoogleAuth);
    // print(user.email);
    var data = {
      "email": isGoogleAuth
          ? user.email
          : isAppleAuth
              ? user.email
              : ConverterUtils.getEmail(user.phoneNumber!),
      "password": isGoogleAuth
          ? user.email!
          : isAppleAuth
              ? user.email!
              : ConverterUtils.getPassword(user.phoneNumber!),
      "phone_number": user.phoneNumber ?? "",
      "role": "064bf10c-e156-4f1c-ae7d-c6c2ce35fe8f",
      "device_token": deviceToken ?? ""
    };

    try {
      var response = await _dio.post(
        "$baseUrl/users",
        data: data,
      );

      if (response.statusCode == 200) {
        await loginUser(
          phoneNumber: isGoogleAuth ? user.email! : user.phoneNumber!,
          isGoogleAuth: isGoogleAuth,
          email: user.email,
          isAppleAuth: isAppleAuth,
        );
      }
    } on DioError catch (e) {
      showErrorFromDio("Error 3", e);
    } on FirebaseAuthException catch (e) {
      showErrorFromFirebase("Error 4", e);
    } catch (e) {
      showErrorFromCatch('Error 67', e);
    }
  }

  Future signInWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: [
          'email',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );

      final isSignedIn = await googleSignIn.isSignedIn();
      if (isSignedIn) {
        await googleSignIn.signOut();
      }
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        UserCredential result =
            await _auth.signInWithCredential(authCredential);

        User? user = result.user;
        if (user != null) {
          _errorController.clearError();
          // print(user.email);
          bool userFound = await isUserFound(user.email!);

          if (userFound) {
            await SharedPref.setNewUser(false);
            await loginUser(
              phoneNumber: user.email!,
              email: user.email,
              isGoogleAuth: true,
              isAppleAuth: false,
            );
          } else {
            await SharedPref.setNewUser(true);
            await _createUser(
              user: user,
              isGoogleAuth: true,
              isAppleAuth: false,
            );
          }
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        showErrorFromFirebase(
            'The account already exists with a different credential', e);
      } else if (e.code == 'invalid-credential') {
        showErrorFromFirebase(
            'Error occurred while accessing credentials. Try again 1', e);
      } else {
        showErrorFromFirebase(
            'Error occurred while accessing credentials. Try again 2', e);
      }
    } catch (e) {
      showErrorFromCatch(
          'Error occurred while accessing credentials. Try again 3', e);
    }
  }

  Future signInWithApple() async {
    final apple_sign_in.AuthorizationResult result =
        await apple_sign_in.TheAppleSignIn.performRequests([
      const apple_sign_in.AppleIdRequest(requestedScopes: [
        apple_sign_in.Scope.email,
        apple_sign_in.Scope.fullName
      ])
    ]);

    switch (result.status) {
      case apple_sign_in.AuthorizationStatus.authorized:
        final apple_sign_in.AppleIdCredential appleIdCredential =
            result.credential!;
        final OAuthProvider oAuthProvider = OAuthProvider('apple.com');
        final credential = oAuthProvider.credential(
            idToken: String.fromCharCodes(appleIdCredential.identityToken!),
            accessToken:
                String.fromCharCodes(appleIdCredential.authorizationCode!));

        final user =
            await FirebaseAuth.instance.signInWithCredential(credential);
      

        _errorController.clearError();
       
        bool userFound = await isUserFound(user.user!.email!);

        if (userFound) {
          await SharedPref.setNewUser(false);
          await loginUser(
            // phoneNumber: user.user!.phoneNumber!,
            phoneNumber: user.user!.email!,
            // email: user.user!.phoneNumber!,
            email: user.user!.email!,
            isGoogleAuth: false,
            isAppleAuth: true,
          );
        } else {
          await SharedPref.setNewUser(true);
          await _createUser(
            user: user.user!,
            isGoogleAuth: false,
            isAppleAuth: true,
          );
        }
     
        return user;

      case apple_sign_in.AuthorizationStatus.error:
        Get.snackbar("Error", "Sign in failed");
        break;

      case apple_sign_in.AuthorizationStatus.cancelled:
        break;
    }
  }

  Future loginUser(
      {required String phoneNumber,
      String? email,
      required bool isGoogleAuth,
      required bool isAppleAuth}) async {
    try {
      final res = await _dio.post(
        '$baseUrl/auth/login',
        data: {
          "email": isGoogleAuth
              ? email
              : isAppleAuth
                  ? email
                  : ConverterUtils.getEmail(phoneNumber),
          "password": isGoogleAuth
              ? email!
              : isAppleAuth
                  ? email!
                  : ConverterUtils.getPassword(phoneNumber),
        },
      );
      if (res.statusCode == 200) {
        String? deviceTokn = await SharedPref.getDeviceToken();
        if (deviceTokn == null) {
          final newDeviceToken = await firebaseMessaging.getToken();
          await SharedPref.setDeviceToken(newDeviceToken!);
          deviceTokn = await SharedPref.getDeviceToken();
        }
        accessToken.value = res.data['data']['access_token'] as String;
        refreshToken.value = res.data['data']['refresh_token'] as String;
        await SharedPref.setAccessToken(accessToken.value!);
        await SharedPref.setRefreshToken(refreshToken.value!);

        await FirebaseMessaging.instance.subscribeToTopic('app');
        switchSignupLoader(false);
        await checkLoginStatus();
      }
    } on DioError catch (e) {
      showErrorFromDio('Error 1', e);
    } catch (e) {
      showErrorFromCatch('Error 3', e);
    }
  }

  Future<bool> isUserFound(String email) async {
    bool val = false;
    try {
      final url = '$baseUrl/user-search?email=$email';
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        val = response.data['userFound'] as bool;
      }

      return val;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> updateRefreshToken(String newRefreshToken) async {
    refreshToken.value = newRefreshToken;
    await SharedPref.setRefreshToken(newRefreshToken);
  }

  Future<void> updateAccessToken(String newAccessToken) async {
    accessToken.value = newAccessToken;
    await SharedPref.setAccessToken(newAccessToken);
  }

  void switchSignupLoader(bool val) {
    signUpLoader.value = val;
  }

  Future<void> signOut() async {
    recentsBox.deleteAllBooks();
    await SharedPref.clearPreferences();
    await checkLoginStatus();
    Get.back(closeOverlays: true);
  }
}
