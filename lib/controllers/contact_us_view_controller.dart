import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/widgets/snackbars.dart';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class ContactUsViewController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final messageController = TextEditingController();
  RxBool isLoading = false.obs;
 

  final nameValidator = MultiValidator([
    RequiredValidator(errorText: "Name is required!"),
  ]);
  final mobileValidator = MultiValidator([
    RequiredValidator(errorText: "Phone Number is required!"),
    MinLengthValidator(10, errorText: "Enter valid phone Number!"),
    MaxLengthValidator(10, errorText: "Enter valid phone Number!"),
  ]);

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: "Email id is required!"),
    EmailValidator(errorText: "Enter Valid email id!")
  ]);

  final messageValidator = MultiValidator([
    RequiredValidator(errorText: "Message is required!"),
  ]);
  bool get loading => isLoading.value;

  switchLoading(bool val) {
    isLoading.value = val;
  }

  Future sentMessage() async {
    switchLoading(true);
    final data = json.encode({
      "email": emailController.text,
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "message": messageController.text,
      "phone_number": phoneController.text,
    });

    var response = await http.post(
      Uri.parse("$baseUrl/items/contact_us"),
      headers: {"Content-Type": "application/json"},
      body: data,
    );

    if (response.statusCode == 204) {
      showSuccess("Sent", "Your Message Has been Sent");
    }
    switchLoading(false);
  }
}
