import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/sub_category_view_controller.dart';
import 'package:veda_nidhi_v2/models/category_model.dart';
import 'package:veda_nidhi_v2/models/get_sub_category_model.dart';
import 'package:veda_nidhi_v2/utils/validate_data_utils.dart';
import 'package:veda_nidhi_v2/views/chapter_views/chapter_view_screen.dart';
import 'package:veda_nidhi_v2/widgets/get_image_from_url.dart';

import '../../widgets/shimmer_widget.dart';

class SubCategoryViewScreen extends StatelessWidget {
  final Category category;
  const SubCategoryViewScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final controller = Get.find<SubCategoryViewController>();
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: FutureBuilder(
                future: controller.getSubCategory(category.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        imageSection(),
                        categoryName(context),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                "Subcategories: ${snapshot.data!.data.length}",
                                style: Theme.of(context).textTheme.bodyMedium),
                          ),
                        ),
                        SizedBox(
                            child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.data.length,
                          itemBuilder: (context, index) {
                            final data = snapshot.data!.data[index];
                            return subCategoryCard(data);
                          },
                        ))
                      ],
                    );
                  }
                  return subCategoryLoader(context, width);
                }),
          ),
        ),
      )),
    );
  }

  Card subCategoryCard(SubCategory data) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Color(0xfff4f4f6),
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        onTap: () {
          Get.to(() => ChapterViewScreen(
                subcategory: data,
                category: category,
              ));
        },
        leading: Container(
          height: 50,
          width: 50,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: const Color(0xfffff0eb),
              borderRadius: BorderRadius.circular(10)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: data.image != null
                ? getImageFromUrlLowRes(
                    //
                    url: data.image!)
                : const SizedBox(),
          ),
        ),
        iconColor: const Color(0xffff6933),
        trailing: Padding(
          padding: const EdgeInsets.only(right: 23.0),
          child: SvgPicture.asset(
            'assets/next_icon1.svg',
            height: 15.48,
            width: 12,
            color: const Color(0xff141a39),
          ),
        ),
        title: Text(
          ValidateDataUtils.validateString(data.name),
          style: const TextStyle(
              fontFamily: 'Metropolis',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Color(0xff141a39)),
        ),
      ),
    );
  }

  Column subCategoryLoader(BuildContext context, double width) {
    return Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: loadingWidget(
              context,
              SizedBox(
                width: width,
                height: 158,
              )),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Align(
            alignment: Alignment.centerLeft,
            child: loadingWidget(
                context,
                SizedBox(
                  width: width * 0.4,
                  height: 30,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Align(
            alignment: Alignment.centerLeft,
            child: loadingWidget(
                context,
                SizedBox(
                  width: width * 0.6,
                  height: 24,
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
                  height: 56,
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
                  height: 56,
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
                  height: 56,
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
                  height: 56,
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
                  height: 56,
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
                  height: 56,
                )),
          ),
        ),
        const SizedBox(
          height: 130,
        ),
      ],
    );
  }

  Padding categoryName(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0, left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          ValidateDataUtils.validateString(category.name),
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }

  ClipRRect imageSection() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(5.0),
        bottomRight: Radius.circular(5.0),
        topLeft: Radius.circular(5.0),
        topRight: Radius.circular(5.0),
      ),
      child: getImageFromUrlLowRes(
        url: category.image,
        height: 158,
        width: 122,
      ),
    );
  }
}
