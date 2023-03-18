import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:veda_nidhi_v2/utils/constants.dart';
import 'auth_service_controller.dart';

class SignUpViewController extends GetxController {
  final TextEditingController phoneNumber = TextEditingController();
  final _authController = Get.find<AuthServiceController>();
  RxBool isLoading = false.obs;
  RxBool isValid = false.obs;

  RxString countryCode = defaultCountryCode.obs;

  String get number => phoneNumber.text;
  bool get loading => isLoading.value;
  bool get valid => isValid.value;
  String get code => countryCode.value;

  Future verifyPhoneNumber() async {
    switchLoading(true);

    await _authController.phoneNumberVerification(
        phoneNumber: phoneNumber.text, countryCode: code);
    switchLoading(false);
  }

  Future googleSignin() async {
    await _authController.signInWithGoogle();
  }

  Future appleSignin() async {
    await _authController.signInWithApple();
  }

  String? validator(PhoneNumber? number) {
    return mobileValidator.errorText;
  }

  final mobileValidator = MultiValidator([
    RequiredValidator(errorText: "Phone Number is required!"),
    MinLengthValidator(10, errorText: "'Invalid Mobile Number'"),
  ]);

  onSelectCountryCode(String code) {
    countryCode.value = code;
  }

  validateField(bool value) {
    isValid.value = value;
  }

  switchLoading(bool val) {
    isLoading.value = val;
  }
}