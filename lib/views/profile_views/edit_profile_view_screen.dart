import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:veda_nidhi_v2/controllers/edit_profile_controller.dart';
import 'package:veda_nidhi_v2/utils/language_utils.dart';

import '../../utils/constants.dart';
import '../../widgets/get_image_from_url.dart';
import '../../widgets/snackbars.dart';

class EditProfileViewScreen extends StatefulWidget {
  const EditProfileViewScreen({super.key});

  @override
  State<EditProfileViewScreen> createState() => _EditProfileViewScreenState();
}

class _EditProfileViewScreenState extends State<EditProfileViewScreen> {
  final ImagePicker picker = ImagePicker();
  final controller = Get.find<EditProfileController>();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xfff4f4f6),
      ),
      backgroundColor: const Color(0xfff4f4f6),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: FutureBuilder(
                future: controller.getValues(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Stack(
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffffffff),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 60),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Color(0xffffffff),
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 60.0,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, top: 10, bottom: 10),
                                    child: Row(
                                      children: const [
                                        Text(
                                          '(Fields marked in * are mandatory)',
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic),
                                        ),
                                      ],
                                    ),
                                  ),
                                  textfieldLabel(context, "Full Name"),
                                  textField(
                                      context,
                                      'Enter Full Name',
                                      controller.fullNameController,
                                      controller.nameValidator),
                                  textfieldLabel(context, "Gothra"),
                                  textField(
                                      context,
                                      'Enter Gothra',
                                      controller.gothraController,
                                      controller.gothraValidator),
                                  textfieldLabel(context, "Institute Name"),
                                  textField(
                                      context,
                                      'Enter Institute Name',
                                      controller.instituteController,
                                      controller.instituteValidator),
                                  textfieldLabel(context, "Guru Name"),
                                  textField(
                                      context,
                                      'Enter Guru Name',
                                      controller.guruNameController,
                                      controller.guruNameValidator),
                                  textfieldLabel(context, "Language"),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 12.0, left: 16, right: 16),
                                    child: SizedBox(
                                      height: 64,
                                      child: InputDecorator(
                                        decoration: InputDecoration(
                                          border: const OutlineInputBorder(),
                                          hintText: controller.language,
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: Obx(
                                            () => DropdownButton<String>(
                                              focusColor: Colors.white,
                                              value: controller.language,
                                              //elevation: 5,
                                              style: const TextStyle(
                                                fontFamily: 'Metropolis',
                                              ),
                                              //   clearIconProperty: IconProperty(color: Colors.orange),
                                              iconEnabledColor: Colors.black,
                                              items: languages.map<
                                                      DropdownMenuItem<String>>(
                                                  (String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(
                                                    value,
                                                    style: const TextStyle(
                                                        color: Colors.black),
                                                  ),
                                                );
                                              }).toList(),
                                              hint: Text(
                                                controller.language,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              onChanged: (String? value) {
                                                controller
                                                    .updateLanguage(value!);
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 70,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 0, bottom: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Container(
                                            height: 54,
                                            width: 164,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color:
                                                      const Color(0xff8f9586),
                                                ),
                                                color: const Color(0xffffffff),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: TextButton(
                                              onPressed: () {
                                                Get.back();
                                              },
                                              child: const Text(
                                                'Cancel',
                                                style: TextStyle(
                                                    color: Color(0xff141a39),
                                                    fontFamily: 'Metropolis',
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 20),
                                          child: Obx(
                                            () => Container(
                                              height: 54,
                                              width: 164,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffff6933),
                                                  borderRadius:
                                                      BorderRadius.circular(5)),
                                              child: controller.isLoading
                                                  ? const Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                      color: Colors.white,
                                                    ))
                                                  : TextButton(
                                                      onPressed: () async {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          FocusScopeNode
                                                              currentFocus =
                                                              FocusScope.of(
                                                                  context);
                                                          if (!currentFocus
                                                              .hasPrimaryFocus) {
                                                            currentFocus
                                                                .unfocus();
                                                          }
                                                          await controller
                                                              .updateValues();
                                                        }
                                                      },
                                                      child: const Text(
                                                        'Save',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffffffff),
                                                            fontFamily:
                                                                'Metropolis',
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 70,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 5,
                          left: 16,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                child: buildProfileImage(
                                    controller.imageId.value,
                                    controller.imageId.value.isNotEmpty),
                              ),
                              InkWell(
                                child: const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: Color(0xffff6933),
                                  child: CircleAvatar(
                                      radius: 14,
                                      backgroundColor: Color(0xffffffff),
                                      child: Icon(
                                        Icons.camera_alt_rounded,
                                        color: Color(0xffff6933),
                                        size: 13.5,
                                      )),
                                ),
                                onTap: () async {
                                  final XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 50);
                                  // ignore: use_build_context_synchronously
                                  if (image != null) {
                                    showBasicSnackbarWithoutCounter(
                                        'Uploading image');
                                    File file = File(image.path);
                                    final res =
                                        await controller.uploadPicture(file);
                                    if (res != null) {}
                                  } else {
                                    showBasicSnackbarWithoutCounter(
                                        'No Image Selected');
                                  }
                                  // controller.onImageButtonPressed();
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
        ),
      ),
    );
  }

  Widget buildProfileImage(path, bool hasImage) => Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(65),
        child: CircleAvatar(
          radius: 48,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: hasImage
                ? getImageFromUrl(width: 100, height: 100, url: path)
                : CachedNetworkImage(
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                    imageUrl: dummyImageUrl,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        Image.asset('assets/MEME.gif'),
                  ),
          ),
        ),
      );

  Padding textField(BuildContext context, String hintText,
      TextEditingController controller, RequiredValidator validator) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 12, bottom: 0),
      child: TextFormField(
        style: Theme.of(context).textTheme.bodyLarge,
        controller: controller,
        validator: validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
}
