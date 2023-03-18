import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/utils/shared_prefs.dart';
import 'package:veda_nidhi_v2/views/langauge_selection_view.dart';

import '../models/user_model.dart';
import 'api_service_controller.dart';

class OnboardingViewController extends GetxController {
  RxBool buttonLoading = false.obs;
  final _apiClient = Get.find<ApiServiceController>();
  final fullNameController = TextEditingController();
  final gothraController = TextEditingController();
  final instituteController = TextEditingController();
  final guruNameController = TextEditingController();
  final nameValidator = RequiredValidator(errorText: "Please Enter Full Name");
  final gothraValidator = RequiredValidator(errorText: "Please Enter Gothra");

  final instituteValidator =
      RequiredValidator(errorText: "Please Enter Institute Name");
  final guruNameValidator =
      RequiredValidator(errorText: "Please Enter Guru Name");

  bool get isLoading => buttonLoading.value;
  Future<UserModel> updateValues() async {
    setLoading(true);
    var data = {
      "gothra": gothraController.text,
      "guru": guruNameController.text,
      "institute_name": instituteController.text,
      "first_name": fullNameController.text.split(" ").first,
      "last_name": fullNameController.text.split(" ").length > 1
          ? fullNameController.text.split(" ").last
          : "",
    };
    final res = await _apiClient.patchData(patchUrl: "users/me", data: data);
    if (res != null) {
      SharedPref.setUserName(fullNameController.text.split(" ").first);
      Get.to(() => const LanguageSelectionViewScreen());
    }

    setLoading(false);
    final user = userModelFromMap(res.toString());

    return user;
  }

  void setLoading(bool val) {
    buttonLoading.value = val;
  }
}
