import 'dart:async';

import 'package:get/get.dart';

import 'auth_service_controller.dart';

class OtpViewController extends GetxController {
  static const defaultTime = 30;
  final _authController = Get.find<AuthServiceController>();

  RxInt secondsRemaining = defaultTime.obs;
  RxBool resentLoading = false.obs;
  RxBool resentEnabled = false.obs;
  RxBool isButtonLoading = false.obs;
  RxString otp = "".obs;
  Timer? timer;

  bool get isResentLoading => resentLoading.value;
  bool get isResentEnabled => resentEnabled.value;
  bool get loading => isButtonLoading.value;
  int get seconds => secondsRemaining.value;
  String get getOtp => otp.value;

  void startTimer() {
    if (secondsRemaining.value == 0) {
      secondsRemaining.value = defaultTime;
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value > 0) {
        secondsRemaining.value = secondsRemaining.value - 1;
      } else {
        resentEnabled.value = true;
        timer.cancel();
      }
    });
  }

  Future verifyOtp(String phoneNumber) async {
    switchLoading(true);
    await _authController.signIn(smsCode: getOtp, phoneNumber: phoneNumber);
    switchLoading(false);
  }

  Future resentOtp(
      {required String phoneNumber, required String countryCode}) async {
    await _authController.reSendOTP(
        phoneNumber: phoneNumber, countryCode: countryCode);
    resentEnabled.value = false;
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  void setOtp(String val) {
    otp.value = val;
  }

  void resetOtp() {
    otp.value = "";
  }

  void switchLoading(bool val) {
    isButtonLoading.value = val;
  }
}
