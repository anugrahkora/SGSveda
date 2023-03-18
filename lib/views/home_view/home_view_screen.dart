import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:veda_nidhi_v2/controllers/home_view_controller.dart';
import 'package:veda_nidhi_v2/main.dart';
import 'package:veda_nidhi_v2/models/banner_model.dart';
import 'package:veda_nidhi_v2/utils/validate_data_utils.dart';
import 'package:veda_nidhi_v2/views/notification_view/notification_view_screen.dart';
import 'package:veda_nidhi_v2/views/profile_views/profile_view_screen.dart';
import 'package:veda_nidhi_v2/views/sub_category_view/sub_category_view_screen.dart';

import '../../widgets/get_image_from_url.dart';
import '../../widgets/shimmer_widget.dart';
import '../../widgets/user_avatar_widget.dart';

class HomeViewScreen extends StatefulWidget {
  const HomeViewScreen({super.key});

  @override
  State<HomeViewScreen> createState() => _HomeViewScreenState();
}

class _HomeViewScreenState extends State<HomeViewScreen> {
  final controller = Get.find<HomeViewController>();
  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
    controller.getCategories();
    controller.addScrollListener();
  }

  @override
  void dispose() {
    controller.clearCategories();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      controller: controller.scrollController,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          topSection(context, controller),
          bannerCarousel(controller, carouselController),
          if (recentsBox.getBooksCount() > 0) headings(context, 'Recent Books'),
          if (recentsBox.getBooksCount() > 0)
            recentBooksBuilderSection(context, controller),
          headings(context, 'Our Categories'),
          categorySection(context),
        ],
      ),
    ));
  }

  Obx categorySection(BuildContext context) {
    return Obx(
      () => Container(
        child: controller.isCatergoryLoading
            ? categoryLoader(context)
            : categoryBuilder(context),
      ),
    );
  }

  Obx categoryBuilder(BuildContext context) {
    return Obx(
      () {
        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
            crossAxisCount: 2,
            childAspectRatio: 3 / 4,
          ),
          itemCount: controller.isNewCatergoryLoading
              ? controller.categories.length + 5
              : controller.categories.length,
          itemBuilder: (_, index) {
            if (index < controller.categories.length) {
              var data = controller.categories[index];
              return InkWell(
                onTap: () async {
                  Get.to(() => SubCategoryViewScreen(category: data));
                },
                child: Container(
                  //color: Colors.white,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border:
                        Border.all(color: const Color(0xfff4f4f6), width: 1),

                    //border:  ,
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(5.0),
                            bottomRight: Radius.circular(5.0),
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0),
                          ),
                          child: getImageFromUrlLowRes(
                            url: data.image,
                            height: 150,
                            width: 120,
                          )),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              ValidateDataUtils.validateString(data.name),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return categoryLoadingCard(context);
            }
          },
        );
      },
    );
  }

  GridView categoryLoader(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 15.0,
        //childAspectRatio: 0.75,
        //crossAxisCount: 2,
        // crossAxisSpacing: 0.0,
        mainAxisSpacing: 10.0,
        mainAxisExtent: 250,
      ),
      itemCount: 10,
      itemBuilder: (_, index) {
        return categoryLoadingCard(context);
      },
    );
  }

  Center categoryLoadingCard(BuildContext context) {
    return Center(
        child: ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: loadingWidget(
        context,
        const AspectRatio(
          aspectRatio: 3 / 4,
        ),
      ),
    ));
  }

  Widget recentBooksBuilderSection(
      BuildContext context, HomeViewController controller) {
    return SizedBox(
      height: 210.0,
      child: GridView.builder(
        scrollDirection: Axis.horizontal,
        // physics: const NeverScrollableScrollPhysics(),
        // shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 4,
          //crossAxisCount: 2,
          crossAxisSpacing: 15.0,
          mainAxisSpacing: 15.0,
          mainAxisExtent: 155,
        ),
        itemCount: recentsBox.getBooksCount(),
        itemBuilder: (_, index) {
          final books = recentsBox.getAllBooks();
          return FutureBuilder(
              future: controller.getCategory(books![index].bookId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return InkWell(
                    onTap: () async {
                      Get.to(() =>
                          SubCategoryViewScreen(category: snapshot.data!));
                    },
                    child: Container(
                      //color: Colors.white,
                      // width: 164,
                      // height: 212,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: const Color(0xfff4f4f6), width: 1),
                        borderRadius: BorderRadius.circular(
                          10.0,
                        ),
                      ),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(5.0),
                                bottomRight: Radius.circular(5.0),
                                topLeft: Radius.circular(5.0),
                                topRight: Radius.circular(5.0),
                              ),
                              child: getImageFromUrlLowRes(
                                  width: 120,
                                  height: 150,
                                  url: books[index].bookImageId)),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: 24,
                              child: Text(
                                books[index].bookName,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox();
              });
        },
      ),
    );
  }

  Padding headings(BuildContext context, String heading) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, bottom: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          heading,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w700),
        ),
      ),
    );
  }

  FutureBuilder<GetBannerModel> bannerCarousel(
      HomeViewController controller, CarouselController carouselController) {
    return FutureBuilder<GetBannerModel>(
      future: controller.getBanners(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var imgList = snapshot.data!.data;
          List<String> bannerUrls =
              imgList.map((e) => e.image.filenameDisk).toList();
          return Column(
            children: [
              carouselSlider(bannerUrls, snapshot.data!.data, controller,
                  carouselController),
              imageSliderIndicator(
                  context, bannerUrls, carouselController, controller)
            ],
          );
        }
        return carouselLoader(carouselController);
      },
    );
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  CarouselSlider carouselSlider(List<String> imgList, List<BannerM> bannerList,
      HomeViewController controller, CarouselController carouselController) {
    return CarouselSlider(
      options: CarouselOptions(
          padEnds: false,
          aspectRatio: 16 / 9,
          initialPage: 0,
          viewportFraction: 0.9,
          enableInfiniteScroll: false,
          reverse: false,
          autoPlay: false,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            controller.setCarouselIndex(index);
          }),
      items: bannerList
          .map((banner) => Center(
                  child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: InkWell(
                      onTap: () async {
                        if (banner.type == "url") {
                          final Uri uri = Uri.parse(banner.url!);

                          _launchInBrowser(uri);
                        } else if (banner.category != null) {
                          Get.to(() => SubCategoryViewScreen(
                              category: banner.category!));
                        }
                      },
                      child: getImageFromUrlMediumRes(
                        url: banner.image.filenameDisk,
                      )),
                ),
              )))
          .toList(),
      carouselController: carouselController,
    );
  }

  CarouselSlider carouselLoader(CarouselController carouselController) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        aspectRatio: 16 / 9,
        initialPage: 0,
        padEnds: false,
        viewportFraction: 0.9,
        autoPlay: false,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      itemCount: 3,
      itemBuilder: (BuildContext context, int itemIndex, int realIndex) {
        return Center(
            child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: loadingWidget(
            context,
            const AspectRatio(
              aspectRatio: 16 / 9,
            ),
          ),
        ));
      },
      carouselController: carouselController,
    );
  }

  Row imageSliderIndicator(BuildContext context, List<String> imgList,
      CarouselController carouselController, HomeViewController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: imgList.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () => carouselController.animateToPage(entry.key),
          child: Obx(
            () => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 8,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 4.0),
              decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.transparent,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  color: (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : const Color(0xffFF6933))
                      .withOpacity(controller.index == entry.key ? 0.9 : 0.4)),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget topSection(BuildContext context, HomeViewController controller) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      selected: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      selectedTileColor: Colors.grey[50],
      title: const Padding(
        padding: EdgeInsets.only(bottom: 15.0),
        child: Text(
          "Hello 👋",
          style: TextStyle(
            fontFamily: 'Metropolis',
            fontWeight: FontWeight.w800,
            fontSize: 24.0,
            color: Color(0xff141a39),
          ),
        ),
      ),
      subtitle: FutureBuilder(
          future: controller.getUserData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                snapshot.data!.data.firstName ?? "User",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(fontWeight: FontWeight.w600, fontSize: 24),
              );
            }
            return Text(
              "User",
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 24),
            );
          }),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () {
              Get.to(() => const NotificationViewScreen());
            },
            child: const CircleAvatar(
              radius: 22,
              backgroundColor: Color(
                0xfff4f4f6,
              ),
              child: Icon(
                Icons.notifications,
                color: Color(0xff603183),
              ),
            ),
          ),
          const SizedBox(
            width: 11,
          ),
          InkWell(
              onTap: () => Get.to(
                    () => const ProfileViewScreen(),
                  ),
              child: FutureBuilder(
                  future: controller.getUserData(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(20),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: Colors.white,
                          child: ClipOval(
                            child: getImageFromUrl(
                                url: snapshot.data!.data.avatar ?? "",
                                height: 100,
                                width: 100),
                          ),
                        ),
                      );
                    }
                    return userAvatar(height: 100, width: 100);
                  })),
        ],
      ),
    );
  }
}
