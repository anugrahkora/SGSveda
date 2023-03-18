import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/onboarding_view_controller.dart';
import 'package:veda_nidhi_v2/widgets/primary_cta.dart';

class OnboardingViewScreen extends StatefulWidget {
  const OnboardingViewScreen({super.key});

  @override
  State<OnboardingViewScreen> createState() => _OnboardingViewScreenState();
}

class _OnboardingViewScreenState extends State<OnboardingViewScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controller = Get.find<OnboardingViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Enter this information",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 12, right: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Here some information you need to add for continue this app ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ),
            textfieldLabel(context, "* Full Name"),
            textField(context, 'Enter Full Name',
                _controller.fullNameController, _controller.nameValidator),
            textfieldLabel(context, "* Gothra"),
            textField(context, 'Enter Gothra', _controller.gothraController,
                _controller.gothraValidator),
            textfieldLabel(context, "* Institute Name"),
            textField(
                context,
                'Enter Institute Name',
                _controller.instituteController,
                _controller.instituteValidator),
            textfieldLabel(context, "* Guru Name"),
            textField(context, 'Enter Guru Name',
                _controller.guruNameController, _controller.guruNameValidator),
            const SizedBox(
              height: 70,
            ),
            Obx(() => primaryButton(
                label: 'Next',
                isLoading: _controller.isLoading,
                onpressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _controller.updateValues();
                  }
                }))
          ]),
        ),
      ),
    ));
  }

  Padding textField(BuildContext context, String hintText,
      TextEditingController controller, RequiredValidator validator) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 0),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyLarge,
        controller: controller,
        validator: validator,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: const Color(0xff8F95A6)),
        ),
      ),
    );
  }

  Padding textfieldLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
