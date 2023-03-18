import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/about_us_view_controller.dart';
import 'package:veda_nidhi_v2/models/about_us_model.dart';
import 'package:veda_nidhi_v2/widgets/get_image_from_url.dart';

import '../../widgets/shimmer_widget.dart';

class AboutUsViewScreen extends StatelessWidget {
  const AboutUsViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = CarouselController();
    final width = MediaQuery.of(context).size.width;
    final controller = Get.find<AboutUsViewController>();
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: FutureBuilder(
            future: controller.getAboutUs(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    imageSlider(
                        carouselController, controller, snapshot, context),
                    heading(context, "About Book App"),
                    info(snapshot.data!.data.aboutBookApp),
                    templeAndSaintCount(snapshot),
                    heading(context, "Who are we?"),
                    info(snapshot.data!.data.whoWeAre),
                    heading(context, "Our Mission"),
                    info(snapshot.data!.data.ourMission),
                  ],
                );
              }
              return aboutLoader(context, carouselController, width);
            }),
      )),
    );
  }

  Column aboutLoader(BuildContext context,
      CarouselController carouselController, double width) {
    return Column(
      children: <Widget>[
        loader(carouselController),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 30),
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
          padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: loadingWidget(
                context,
                SizedBox(
                  width: width,
                  height: 200,
                )),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              loadingWidget(
                  context,
                  SizedBox(
                    width: width * 0.45,
                    height: 100,
                  )),
              loadingWidget(
                  context,
                  SizedBox(
                    width: width * 0.45,
                    height: 100,
                  )),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 24, right: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: loadingWidget(
                context,
                SizedBox(
                  width: width,
                  height: 200,
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

  Padding info(String info) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16, right: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          info,
          style: const TextStyle(
              color: Color(0xff515869),
              fontFamily: 'Metropolis',
              fontSize: 15,
              fontWeight: FontWeight.w400),
        ),
      ),
    );
  }

  Padding templeAndSaintCount(AsyncSnapshot<GetAboutUsModel> snapshot) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 121,
              width: 155,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: const Color(0xfff4f4f6))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: const Color(0xfffff0eb),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.95,
                          left: 16.75,
                        ),
                        child: SizedBox(
                          height: 15.75,
                          width: 15.74,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: const Color(0xfffff0eb),
                                borderRadius: BorderRadius.circular(10)),
                            child: SvgPicture.asset(
                              'assets/temples.svg',
                              color: const Color(0xffff6933),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data!.data.totalTemple,
                    style: const TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Total Temple',
                    style: TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Container(
              height: 121,
              width: 155,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: const Color(0xfff4f4f6))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: const Color(0xfffff0eb),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 16.95,
                          left: 16.75,
                        ),
                        child: SizedBox(
                          height: 15.75,
                          width: 15.74,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                                color: const Color(0xfffff0eb),
                                borderRadius: BorderRadius.circular(10)),
                            child: SvgPicture.asset(
                              'assets/saints.svg',
                              color: const Color(0xffff6933),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data!.data.totalSaints,
                    style: const TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Total Saints',
                    style: TextStyle(
                        fontFamily: 'Metropolis',
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  Padding heading(BuildContext context, String heading) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          heading,
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .copyWith(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
    );
  }

  Stack imageSlider(
      CarouselController carouselController,
      AboutUsViewController controller,
      AsyncSnapshot<GetAboutUsModel> snapshot,
      BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        CarouselSlider(
          carouselController: carouselController,
          options: CarouselOptions(
              viewportFraction: 1,
              enlargeCenterPage: true,
              aspectRatio: 16 / 7,
              autoPlay: true,
              onPageChanged: (val, _) {
                controller.setCarouselIndex(val);
              }),
          items: snapshot.data!.data.banners.map((banner) {
            return Center(
              child: getImageFromUrl(
                  width: double.infinity,
                  height: double.infinity,
                  url: banner.directusFilesId),
            );
          }).toList(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: imageSliderIndicator(
              context,
              snapshot.data!.data.banners
                  .map((e) => e.directusFilesId)
                  .toList(),
              carouselController,
              controller),
        ),
      ],
    );
  }

  CarouselSlider loader(CarouselController carouselController) {
    return CarouselSlider.builder(
      options: CarouselOptions(
        viewportFraction: 1,
        enlargeCenterPage: true,
        aspectRatio: 16 / 7,
      ),
      itemCount: 3,
      itemBuilder: (BuildContext context, int itemIndex, int realIndex) {
        return Center(
            child: loadingWidget(
          context,
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
        ));
      },
      carouselController: carouselController,
    );
  }

  Row imageSliderIndicator(BuildContext context, List<String> imgList,
      CarouselController carouselController, AboutUsViewController controller) {
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
                          : Colors.white)
                      .withOpacity(controller.index == entry.key ? 0.9 : 0.4)),
            ),
          ),
        );
      }).toList(),
    );
  }
}
