import 'constants.dart';

class ConverterUtils {
  static String getEmail(String phoneNumber) {
    return "${splitString(phoneNumber)}$emailTail";
  }

// function which removes the country code from phone number
  static String splitString(String string) {
    return string.substring(string.length - 10);
  }

  static String getPassword(String phoneNumber) {
    return splitString(phoneNumber)
        .split('')
        .reversed
        .join();
  }
}