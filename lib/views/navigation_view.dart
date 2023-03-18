import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:veda_nidhi_v2/utils/shared_prefs.dart';
import 'package:veda_nidhi_v2/views/about_us_view/about_us_view_screen.dart';
import 'package:veda_nidhi_v2/views/home_view/home_view_screen.dart';
import 'package:veda_nidhi_v2/views/my_download_view/my_download_view_screen.dart';
import 'package:veda_nidhi_v2/views/onboarding_view_screen.dart';
import 'package:veda_nidhi_v2/views/profile_views/profile_view_screen.dart';

import '../controllers/navigation_controller.dart';
import 'contact_us_views/contact_us_view_screen.dart';

class NavigationViewScreen extends StatefulWidget {
  const NavigationViewScreen({super.key});

  @override
  State<NavigationViewScreen> createState() => _NavigationViewScreenState();
}

class _NavigationViewScreenState extends State<NavigationViewScreen> {
  @override
  void initState() {
    checkifShouldOnBoard();
    super.initState();
  }

  Future checkifShouldOnBoard() async {
    final shouldOnBoard = await SharedPref.isNewUser();
    if (shouldOnBoard != null && shouldOnBoard) {
      Get.to(() => const OnboardingViewScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomeViewScreen(),
      const MyDownloadViewScreen(),
      const AboutUsViewScreen(),
      const ContactUsViewScreen(),
      const ProfileViewScreen()
    ];
    final navigationController = Get.find<NavigationController>();
    return Scaffold(
      body: GetX<NavigationController>(
        builder: (controller) {
          return PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) =>
                FadeThroughTransition(
              animation: primaryAnimation,
              secondaryAnimation: secondaryAnimation,
              fillColor: Theme.of(context).scaffoldBackgroundColor,
              child: child,
            ),
            child: pages[navigationController.tab],
          );
        },
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/home_icon.svg', color: const Color(0xff515869),
                  // height: 14.74, width: 16.5,
                ),
                label: 'Home',
                activeIcon: SvgPicture.asset(
                  'assets/home_icon.svg',
                  color: const Color(0xffff577f),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/download_icon.svg',
                  color: const Color(0xff515869),
                ),
                label: 'My Download',
                activeIcon: SvgPicture.asset(
                  'assets/download_icon.svg',
                  color: const Color(0xffff577f),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/Aboutus_icon.svg',
                  color: const Color(0xff515869),
                ),
                label: 'About Us',
                activeIcon: SvgPicture.asset(
                  'assets/Aboutus_icon.svg',
                  color: const Color(0xffff577f),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/call_icon1.svg',
                  color: const Color(0xff515869),
                ),
                label: 'Contact Us',
                activeIcon: SvgPicture.asset(
                  'assets/call_icon1.svg',
                  color: const Color(0xffff577f),
                ),
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/user_icon.svg',
                  color: const Color(0xff515869),
                ),
                label: 'Profile',
                activeIcon: SvgPicture.asset(
                  'assets/user_icon.svg',
                  color: const Color(0xffff577f),
                ),
              ),
            ],
            type: BottomNavigationBarType.fixed,
            currentIndex: navigationController.tab,
            unselectedItemColor: Colors.black,
            selectedFontSize: 10,
            unselectedFontSize: 10,
            selectedItemColor: const Color(0xffff577f),
            showUnselectedLabels: true,
            iconSize: 18,
            unselectedLabelStyle: const TextStyle(
              height: 2,
            ),
            onTap: (value) {
              navigationController.setTab(value);
            },
            elevation: 0);
      }),
    );
  }
}
