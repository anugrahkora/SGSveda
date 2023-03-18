import 'dart:io';
import 'package:dio/dio.dart' as d;
// ignore: implementation_imports
import 'package:dio/src/multipart_file.dart' as mlt;
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/utils/shared_prefs.dart';
import 'package:veda_nidhi_v2/widgets/snackbars.dart';

import '../models/upload_file_response_model.dart';
import '../models/user_model.dart';
import 'api_service_controller.dart';

class EditProfileController extends GetxController {
  RxBool buttonLoading = false.obs;
  final _apiClient = Get.find<ApiServiceController>();
  RxString imageId = ''.obs;

  final fullNameController = TextEditingController();
  final gothraController = TextEditingController();
  final instituteController = TextEditingController();
  final guruNameController = TextEditingController();
  final nameValidator = RequiredValidator(errorText: "Please Enter Full Name");
  final gothraValidator = RequiredValidator(errorText: "Please Enter Gothra");
  final selectedLanguage = ''.obs;

  final instituteValidator =
      RequiredValidator(errorText: "Please Enter Institute Name");
  final guruNameValidator =
      RequiredValidator(errorText: "Please Enter Guru Name");

  bool get isLoading => buttonLoading.value;
  // bool get hasProfileUpdate => image != null;
  String get language => selectedLanguage.value;

  Future<UserModel> getValues() async {
    final res = await _apiClient.fetchData(fetchUrl: "users/me");
    final user = userModelFromMap(res.toString());
    fullNameController.text =
        "${user.data.firstName ?? ''}  ${user.data.lastName ?? ''}";
    fullNameController.text = fullNameController.text.trim();
    gothraController.text = user.data.gothra ?? "";
    instituteController.text = user.data.instituteName ?? "";
    guruNameController.text = user.data.guru ?? "";
    imageId.value = user.data.avatar ?? "";
    selectedLanguage.value = user.data.language ?? "Kannada";
    return userModelFromMap(res.toString());
  }

  bool checkIfAllValuesAreEmpty(bool hasFile) {
    return fullNameController.text.isEmpty &&
            gothraController.text.isEmpty &&
            instituteController.text.isEmpty &&
            guruNameController.text.isEmpty &&
            !hasFile
        ? true
        : false;
  }

  void setImage(String image) {
    imageId.value = image;
  }

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
      "language": language
    };
    final res = await _apiClient.patchData(patchUrl: "users/me", data: data);

    if (res != null) {
      showSuccess("Updated", "Your Profile has been Successfully updated");
    }
    setLoading(false);
    final user = userModelFromMap(res.toString());
    await SharedPref.setUserName(user.data.firstName);

    return user;
  }

  Future<UserModel> updateProfile(String photoUrl) async {
    setLoading(true);
    var data = {
      "avatar": photoUrl,
    };
    final res = await _apiClient.patchData(patchUrl: "users/me", data: data);

    if (res != null) {
      await SharedPref.setProfileId(photoUrl);
      showSuccess("Updated", "Your Profile has been Successfully updated");
    }
    setLoading(false);
    final user = userModelFromMap(res.toString());

    return user;
  }

  Future<UploadFileResponse?> uploadPicture(File file) async {
    UploadFileResponse? uploadFileResponse;
    const url = "files";
    var data = d.FormData.fromMap({
      "title": file.path,
      "filename_download": DateTime.now().millisecondsSinceEpoch.toString(),
      "file": await mlt.MultipartFile.fromFile(file.path)
    });

    final res = await _apiClient.postData(postUrl: url, data: data);
    uploadFileResponse = uploadFileResponseFromMap(res.toString());
    final photoUrl = uploadFileResponse.data.id;
    await updateProfile(photoUrl);

    return uploadFileResponse;
  }

  void setLoading(bool val) {
    buttonLoading.value = val;
  }

  void updateLanguage(String val) {
    selectedLanguage.value = val;
  }
}
