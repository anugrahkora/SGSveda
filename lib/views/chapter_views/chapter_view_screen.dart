import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/chapter_view_screen_controller.dart';
import 'package:veda_nidhi_v2/utils/language_utils.dart';
import 'package:veda_nidhi_v2/utils/validate_data_utils.dart';

import '../../models/category_model.dart';
import '../../models/get_sub_category_model.dart';
import '../../widgets/chapter_card_widget.dart';
import '../../widgets/shimmer_widget.dart';

class ChapterViewScreen extends StatelessWidget {
  final SubCategory subcategory;
  final Category category;
  const ChapterViewScreen(
      {super.key, required this.subcategory, required this.category});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final controller = Get.find<ChapterViewScreenController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfff4f4f6),
        title: Text(ValidateDataUtils.validateString(subcategory.name)),
        centerTitle: true,
      ),
      body: SafeArea(
          child: FutureBuilder(
        future: controller.getChapters(subcategory.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.data.isEmpty) {
              return const Center(
                child: Text('Chapters not added yet.'),
              );
            }
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data!.data.length,
              itemBuilder: (BuildContext context, int index) {
                var data = snapshot.data!.data[index];

                return FutureBuilder(
                    future: controller.getUserData(),
                    builder: (context, snapshot1) {
                      if (snapshot1.hasData) {
                        final language =
                            snapshot1.data!.data.language as String;

                        String? fileId;
                        String? fileName;
                        if (language == languages[0]) {
                          if (data.devanagariFile != null) {
                            fileId = data.devanagariFile!.id;
                            fileName = data.devanagariFile!.filenameDownload;
                          }
                        } else if (language == languages[1]) {
                          if (data.kannadaFile != null) {
                            fileId = data.kannadaFile!.id;
                            fileName = data.kannadaFile!.filenameDownload;
                          }
                        } else if (language == languages[2]) {
                          if (data.telugu != null) {
                            fileId = data.telugu!.id;
                            fileName = data.telugu!.filenameDownload;
                          }
                        }
                        return ChapterCardWidget(
                          fileNameDownload: fileName,
                          data: data,
                          fileId: fileId,
                          category: category,
                        );
                      }
                      return const SizedBox();
                    });
              },
            );
          }
          return subCategoryLoader(context, width);
        },
      )),
    );
  }

  Widget subCategoryLoader(BuildContext context, double width) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: loadingWidget(
                  context,
                  SizedBox(
                    width: width,
                    height: 72,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: loadingWidget(
                  context,
                  SizedBox(
                    width: width,
                    height: 72,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: loadingWidget(
                  context,
                  SizedBox(
                    width: width,
                    height: 72,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: loadingWidget(
                  context,
                  SizedBox(
                    width: width,
                    height: 72,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: loadingWidget(
                  context,
                  SizedBox(
                    width: width,
                    height: 72,
                  )),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24),
            child: Align(
              alignment: Alignment.centerLeft,
              child: loadingWidget(
                  context,
                  SizedBox(
                    width: width,
                    height: 72,
                  )),
            ),
          ),
          const SizedBox(
            height: 130,
          ),
        ],
      ),
    );
  }
}
