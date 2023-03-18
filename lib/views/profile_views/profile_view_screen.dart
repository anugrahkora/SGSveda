import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/auth_service_controller.dart';
import 'package:veda_nidhi_v2/controllers/profile_view_controller.dart';
import 'package:veda_nidhi_v2/widgets/shimmer_widget.dart';

import '../../utils/constants.dart';
import '../../widgets/get_image_from_url.dart';
import 'edit_profile_view_screen.dart';

class ProfileViewScreen extends StatelessWidget {
  const ProfileViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthServiceController>();
    final controller = Get.find<ProfileViewController>();
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "My Profile",
        ),
        backgroundColor: const Color(0xfff4f4f6),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => const EditProfileViewScreen());
            },
            icon: SizedBox(
              height: 15,
              width: 15,
              child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: const Color(0xfff4f4f6),
                      borderRadius: BorderRadius.circular(10)),
                  child: SvgPicture.asset(
                    'assets/pen.svg',
                  )),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xfff4f4f6),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: FutureBuilder(
              future: controller.getUserData(),
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 16, top: 60),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      snapshot.data!.data.firstName ?? "",
                                      style: const TextStyle(
                                          color: Color(0xff141A39),
                                          fontFamily: 'Metropolis',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                ),
                                headings(context, 'Gothra Name'),
                                values(snapshot.data!.data.gothra ?? ""),
                                headings(context, "Institute Name"),
                                values(snapshot.data!.data.instituteName ?? ""),
                                headings(context, "Guru Name"),
                                values(snapshot.data!.data.guru ?? ""),
                                headings(context, "Language"),
                                values(snapshot.data!.data.language ?? ""),
                                logoutCta(
                                  context,
                                  () async {
                                    await authController.signOut();
                                  },
                                ),
                                const SizedBox(
                                  height: 130,
                                ),
                              ],
                            )),
                      ),
                      Positioned(
                        top: 5,
                        left: 16,
                        child: Container(
                          child: buildProfileImage(snapshot.data!.data.avatar),
                        ),
                      ),
                    ],
                  );
                } else {
                  return profileLoader(context, width);
                }
              }),
        ),
      ),
    );
  }

  Column profileLoader(BuildContext context, double width) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 60),
          child: Align(
            alignment: Alignment.centerLeft,
            child: loadingWidget(
                context,
                SizedBox(
                  width: width * 0.5,
                  height: 36,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 24),
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
          padding: const EdgeInsets.only(left: 16, top: 12),
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
          padding: const EdgeInsets.only(left: 16, top: 24),
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
          padding: const EdgeInsets.only(left: 16, top: 12),
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
          padding: const EdgeInsets.only(left: 16, top: 24),
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
          padding: const EdgeInsets.only(left: 16, top: 12),
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
          padding: const EdgeInsets.only(left: 16, top: 24),
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
          padding: const EdgeInsets.only(left: 16, top: 12),
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
        const SizedBox(
          height: 130,
        ),
      ],
    );
  }

  Widget buildProfileImage(String? path) => Material(
        elevation: 10,
        borderRadius: BorderRadius.circular(65),
        child: CircleAvatar(
          radius: 48,
          backgroundColor: Colors.white,
          child: ClipOval(
            child: path != null
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
  Padding logoutCta(BuildContext context, Function() onPressed) {
    return Padding(
      padding: const EdgeInsets.only(top: 85, bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              height: 54,
              width: 164,
              decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  borderRadius: BorderRadius.circular(5)),
              child: TextButton(
                onPressed: onPressed,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 30.0),
                      child: SizedBox(
                          height: 20,
                          width: 20,
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  color: const Color(0xffffffff),
                                  borderRadius: BorderRadius.circular(10)),
                              child: SvgPicture.asset(
                                'assets/logout.svg',
                                // color: Color(0xff603183),
                              ))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 11.0),
                      child: Text(
                        'Logout',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding headings(BuildContext context, String heading) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(heading,
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: const Color(0xff8f95a6))),
      ),
    );
  }

  Padding values(String val) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          val,
          style: const TextStyle(
              color: Color(0xff141a39),
              fontFamily: 'Metropolis',
              fontSize: 14,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
