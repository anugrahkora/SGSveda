import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static String accessToken = 'access_token';
  static String refreshToken = 'refresh_token';
  static String userEmail = 'email';
  static String userPassword = 'password';
  static String newUser = 'isNew';
  static String isLoggedIn = 'isLoggedIn';
  static String deviceToken = 'devToken';
  static String userName = 'UserName';
  static String profileId = 'profileId';



  static Future setAccessToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(accessToken, token);
  }

  static Future setRefreshToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(refreshToken, token);
  }

  static Future setUserEmail(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userEmail, token);
  }

  static Future removeUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.remove(userEmail);
  }

  static Future removeUserPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.remove(userPassword);
  }

  static Future setUserPassword(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userPassword, token);
  }
  static Future setProfileId(String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(profileId, id);
  }

  static Future setNewUser(bool isNewUser) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(newUser, isNewUser);
  }

  static Future setIsLoggedIn(bool loggedIn) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setBool(isLoggedIn, loggedIn);
  }

  static Future setDeviceToken(String newToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(deviceToken, newToken);
  }
  static Future setUserName(String name) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return await preferences.setString(userName, name);
  }



  static Future<bool> isUserLoggedIn() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.containsKey(accessToken);
  }
  static Future<bool?> isNewUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(newUser);
  }

  static Future<bool> clearPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.clear();
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(accessToken);
  }
  static Future<String?> getUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userName);
  }
  static Future<String?> getProfileId() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(profileId);
  }

  static Future<String?> getRefreshToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(refreshToken);
  }

  static Future<String?> getUserEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userEmail);
  }

  static Future<String?> getDeviceToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(deviceToken);
  }

  static Future<String?> getUserPassword() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(userPassword);
  }
}
