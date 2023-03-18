import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/auth_service_controller.dart';

import 'package:veda_nidhi_v2/views/navigation_view.dart';

import 'package:veda_nidhi_v2/views/signup_view_screen.dart';


class UserAuthCheck extends StatelessWidget {
  const UserAuthCheck({super.key});

  void fcmSubscribe() async {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    await firebaseMessaging.subscribeToTopic('app');
  }


  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthServiceController>();
    if (authController.isLoggedIn.value) {
      fcmSubscribe();
    }
    return Obx(()=>authController.isLoggedIn.value? const NavigationViewScreen():const SignUpViewScreen());
  }
}
