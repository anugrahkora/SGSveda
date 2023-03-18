import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/language_selection_view_controller.dart';
import 'package:veda_nidhi_v2/widgets/primary_cta.dart';

import '../utils/language_utils.dart';
import '../widgets/primary_appbar.dart';

class LanguageSelectionViewScreen extends StatelessWidget {
  const LanguageSelectionViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LanguageSelectionViewController>();
    return Scaffold(
      appBar: primaryAppBar(context),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Choose the Language',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  itemCount: languages.length,
                  itemBuilder: (context, index) {
                    return Obx(
                      () => Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 8),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide(
                              color: controller.language == index
                                  ? const Color(0xffff6933)
                                  : const Color(0xff8f95a6)),
                        ),
                        child: ListTile(
                          onTap: () {
                            controller.changeLanguage(index);
                          },
                          leading: SizedBox(
                              height: 14.25,
                              width: 15.3,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffffffff),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: SvgPicture.asset(
                                    'assets/language_icon1.svg',
                                    color: const Color(0xff603183),
                                  ))),
                          iconColor: const Color(0xffff6933),
                          trailing: controller.language == index
                              ? const Icon(Icons.check_circle)
                              : const SizedBox(),
                          title: Text(
                            languages[index],
                            style: const TextStyle(
                                fontFamily: 'Metropolis',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: Color(0xff141a39)),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Obx(
              () => primaryButton(
                  label: 'Next',
                  isLoading: controller.isLoading,
                  onpressed: () async {
                    await controller.saveLanguage();
                  
                  }),
            ),
            const SizedBox(
              height: 72.0,
            ),
          ],
        ),
      ),
    );
  }
}
