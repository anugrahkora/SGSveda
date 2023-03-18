import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/auth_service_controller.dart';
import 'package:veda_nidhi_v2/user_auth_state_check.dart';


class SplashViewScreen extends StatelessWidget {
  const SplashViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthServiceController>();
    //  final networkController = Get.find<NetworkController>();
    return Scaffold(
      body: FutureBuilder(
          future: authController.checkLoginStatus(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const UserAuthCheck();
            }
            return splashWidget();
          }),
    );
  }

  SafeArea splashWidget() {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage(
            'assets/splash_image.png',
          ),
          fit: BoxFit.cover,
        )),
      ),
    );
  }
}
