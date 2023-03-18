import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veda_nidhi_v2/controllers/notifications_view_controller.dart';
import 'package:veda_nidhi_v2/utils/validate_data_utils.dart';
import 'package:veda_nidhi_v2/views/sub_category_view/sub_category_view_screen.dart';
import 'package:veda_nidhi_v2/widgets/shimmer_widget.dart';

import '../../utils/constants.dart';

class NotificationViewScreen extends StatelessWidget {
  const NotificationViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final controller = Get.find<NotificationViewController>();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Notifications',
        ),
      ),
      body: FutureBuilder(
        future: controller.getNotifications(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.data.length,
              itemBuilder: (context, index) {
                var dataRc = snapshot.data!.data.toList();
                var data = dataRc[index];

                return InkWell(
                  onTap: () {
                    if (data.type == "url") {
                      final Uri uri = Uri.parse(data.url!);

                      Future<void> launchInBrowser(Uri url) async {
                        if (!await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        )) {
                          throw 'Could not launch $url';
                        }
                      }

                      launchInBrowser(uri);
                    } else if (data.category != null) {
                      Get.to(() => SubCategoryViewScreen(
                            category: data.category!,
                          ));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(5.0),
                                  bottomRight: Radius.circular(5.0),
                                  topLeft: Radius.circular(5.0),
                                  topRight: Radius.circular(5.0),
                                ),
                                child: data.image != null
                                    ? CachedNetworkImage(
                                        imageUrl:
                                            "$baseUrl/assets/${data.image!.id}",
                                        height: 60,
                                        width: 60,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            loadingWidget(
                                                context, const SizedBox()),
                            
                                      )
                                    : const SizedBox()),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(ValidateDataUtils.validateString(
                                          data.title),
                                      maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      )),
                                  Text(ValidateDataUtils.validateString(
                                          data.body),
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      )),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return notificationsLoader(context, width);
        },
      ),
    );
  }

  Widget notificationsLoader(BuildContext context, double width) {
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
