import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:veda_nidhi_v2/controllers/auth_service_controller.dart';
import 'package:veda_nidhi_v2/controllers/signup_view_controller.dart';
import '../widgets/primary_cta.dart';
import 'dart:io' show Platform;

class SignUpViewScreen extends StatefulWidget {
  const SignUpViewScreen({super.key});

  @override
  State<SignUpViewScreen> createState() => _SignUpViewScreenState();
}

class _SignUpViewScreenState extends State<SignUpViewScreen> {
  final controller = Get.find<SignUpViewController>();
  final authController = Get.find<AuthServiceController>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              welcomeHeading(context),
              mobileNumberHeading(context),
              subInformation(context),
              mobileFieldLabel(context),
              phoneNumberField(context, controller, _formKey),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 16, right: 16),
                child: Obx(
                  () => primaryButton(
                    label: "Send OTP",
                    isLoading: authController.signUpLoader.value,
                    onpressed: () async {
                      if (_formKey.currentState!.validate()) {
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        await controller.verifyPhoneNumber();
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'or Continue with',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Row(
                mainAxisAlignment: Platform.isIOS ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 54,
                      width: 164,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8f9586),
                          ),
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextButton(
                        onPressed: () async {
                          await controller.googleSignin();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.asset(
                                      'assets/google_icon.png',
                                      // color: Color(0xff603183),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 11.0),
                                child: Text(
                                  'Google',
                                  style: TextStyle(
                                      color: Color(0xffeb4132),
                                      fontFamily: 'Metropolis',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Platform.isIOS ?
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Container(
                      height: 54,
                      width: 164,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xff8f9586),
                          ),
                          color: const Color(0xffffffff),
                          borderRadius: BorderRadius.circular(5)),
                      child: TextButton(
                        onPressed: () async {
                          await controller.appleSignin();
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: DecoratedBox(
                                    decoration: BoxDecoration(
                                        color: const Color(0xffffffff),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Image.asset(
                                      'assets/apple_icon.png',
                                      // color: Color(0xff603183),
                                    ),
                                  ),
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 11.0),
                                child: Text(
                                  'Apple',
                                  style: TextStyle(
                                      color: Color(0xff141a39),
                                      fontFamily: 'Metropolis',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ) : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding phoneNumberField(BuildContext context,
      SignUpViewController controller, GlobalKey<FormState> key) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0, left: 16, right: 16),
      child: Form(
        key: key,
        child: IntlPhoneField(
          dropdownTextStyle: const TextStyle(
            fontSize: 16,
          ),
          validator: (number) => controller.validator(number),
          style: Theme.of(context).textTheme.bodyLarge,
          showCountryFlag: false,
          initialCountryCode: 'IN',
          decoration: InputDecoration(
            counter: const Offstage(),
            hintText: 'Enter mobile number',
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: const Color(0xff8F95A6)),
            border: const OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          controller: controller.phoneNumber,
          onCountryChanged: (country) {
            controller.onSelectCountryCode(country.dialCode);
          },
        ),
      ),
    );
  }

  Padding mobileFieldLabel(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 32),
      child: Align(
        alignment: Alignment.centerLeft,
        child:
            Text("Mobile Number", style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }

  Padding subInformation(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text("You will receive a 6 digit code to verify your number.",
            style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  Padding mobileNumberHeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 30),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text("Enter Your Mobile Number",
            style: Theme.of(context).textTheme.titleMedium),
      ),
    );
  }

  Padding welcomeHeading(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 60),
      child: Align(
        alignment: Alignment.centerLeft,
        child:
            Text("Welcome 👋", style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
