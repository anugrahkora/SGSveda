import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veda_nidhi_v2/controllers/contact_us_view_controller.dart';
import 'package:veda_nidhi_v2/utils/constants.dart';
import 'package:veda_nidhi_v2/widgets/primary_cta.dart';

class ContactUsViewScreen extends StatefulWidget {
  const ContactUsViewScreen({super.key});

  @override
  State<ContactUsViewScreen> createState() => _ContactUsViewScreenState();
}

class _ContactUsViewScreenState extends State<ContactUsViewScreen> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<ContactUsViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                topSection(),
                heading(
                    context,
                    "Contact us for a quote, help to join the team",
                    Alignment.center,
                    TextAlign.center),
                phoneCallSection(),
                emailSection(),
                locationSection(),
                const SizedBox(
                  height: 16,
                ),
                heading(context, "Get in touch", Alignment.centerLeft,
                    TextAlign.start),
                valuesItalic('(Fields marked in * are mandatory)'),
                textFieldLabel(context, "First Name"),
                textField(controller.firstNameController, 'Enter First Name',
                    controller.nameValidator),
                textFieldLabel(context, "Last Name"),
                textField(controller.lastNameController, 'Enter Last Name',
                    controller.nameValidator),
                textFieldLabel(context, "Email"),
                textField(controller.emailController, 'Enter Email',
                    controller.emailValidator),
                textFieldLabel(context, "Phone Number"),
                textField(controller.phoneController, 'Enter Phone Number',
                    controller.mobileValidator),
                textFieldLabel(context, "Message"),
                textField(controller.messageController, 'Enter Message',
                    controller.messageValidator,
                    maxlines: 10),
                const SizedBox(
                  height: 32,
                ),
                Obx(
                  () => primaryButton(
                      label: 'Submit',
                      isLoading: controller.loading,
                      onpressed: () async {
                        if (_formKey.currentState!.validate()) {
                          FocusScopeNode currentFocus = FocusScope.of(context);
                          if (!currentFocus.hasPrimaryFocus) {
                            currentFocus.unfocus();
                          }
                          await controller.sentMessage();
                        }
                      }),
                ),
                const SizedBox(
                  height: 16,
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell locationSection() {
    return InkWell(
      onTap: () async {
        await MapsLauncher.launchQuery(locationInfo);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              SizedBox(
                  height: 40,
                  width: 40,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: const Color(0xfffff0eb),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.location_pin,
                        color: Color(0xffff6933),
                      ))),
              const SizedBox(
                width: 10,
              ),
              values(locationInfo),
            ],
          ),
        ),
      ),
    );
  }

  Padding textField(TextEditingController controller, String hintText,
      MultiValidator validator,
      {int? maxlines}) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 12, bottom: 0),
      //padding: EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
          style: Theme.of(context).textTheme.bodyLarge,
          controller: controller,
          validator: validator,
          maxLines: maxlines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            hintStyle: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: const Color(0xff8F95A6)),
          )),
    );
  }

  Padding textFieldLabel(BuildContext context, String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Text(
              ' * ',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  InkWell emailSection() {
    return InkWell(
      onTap: () async {
        String mail = Uri.encodeComponent(email);

        Uri uri = Uri.parse("mailto:$mail");
        if (await launchUrl(uri)) {
        } else {
          Get.snackbar("failed", "failed to open mail");
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 16, top: 12),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              SizedBox(
                  height: 40,
                  width: 40,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: const Color(0xfffff0eb),
                          borderRadius: BorderRadius.circular(10)),
                      child: const Icon(
                        Icons.mail,
                        color: Color(0xffff6933),
                      ))),
              const SizedBox(
                width: 10,
              ),
              values(email),
            ],
          ),
        ),
      ),
    );
  }

  Padding phoneCallSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 12),
      child: Align(
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () async {
            await _makePhoneCall(phoneNumber);
          },
          child: Row(
            children: [
              SizedBox(
                height: 40,
                width: 40,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: const Color(0xfffff0eb),
                      borderRadius: BorderRadius.circular(10)),
                  child: const Icon(
                    Icons.call,
                    color: Color(0xffff6933),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              values(phoneNumber),
            ],
          ),
        ),
      ),
    );
  }

  Padding values(String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
      child: Text(
        value,
        style: const TextStyle(
            color: Color(0xff515869),
            fontFamily: 'Metropolis',
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Padding valuesItalic(String value) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10, bottom: 10),
      child: Row(
        children: [
          Text(
            value,
            textAlign: TextAlign.start,
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Padding heading(BuildContext context, String heading, Alignment alignment,
      TextAlign textAligh) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Align(
        alignment: alignment,
        child: Text(heading,
            textAlign: textAligh,
            style: Theme.of(context).textTheme.titleSmall),
      ),
    );
  }

  Padding topSection() {
    return Padding(
      // padding: const EdgeInsets.only(top: 34.30),
      padding: const EdgeInsets.only(top: 0.0),
      child: Stack(children: [
        Container(
          height: 175,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/contact_us.png"), fit: BoxFit.cover),
          ),
        ),
        Opacity(
          opacity: 0.7,
          child: Container(
            height: 175,
            decoration: const BoxDecoration(
              color: Color(0xff141a39),
            ),
          ),
        ),
        const Positioned(
          top: 70,
          left: 149,
          child: Center(
            child: Text(
              "Contact us",
              style: TextStyle(
                  color: Color(0xffffffff),
                  fontFamily: 'Metropolis',
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ),
      ]),
    );
  }
}
