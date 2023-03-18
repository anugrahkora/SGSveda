import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/about_us_view_controller.dart';
import 'package:veda_nidhi_v2/controllers/chapter_view_screen_controller.dart';
import 'package:veda_nidhi_v2/controllers/error_status_controller.dart';
import 'package:veda_nidhi_v2/controllers/home_view_controller.dart';
import 'package:veda_nidhi_v2/controllers/language_selection_view_controller.dart';
import 'package:veda_nidhi_v2/controllers/navigation_controller.dart';
import 'package:veda_nidhi_v2/controllers/network_controller.dart';
import 'package:veda_nidhi_v2/controllers/notifications_view_controller.dart';
import 'package:veda_nidhi_v2/controllers/onboarding_view_controller.dart';
import 'package:veda_nidhi_v2/controllers/otp_view_controller.dart';
import 'package:veda_nidhi_v2/controllers/profile_view_controller.dart';
import 'package:veda_nidhi_v2/controllers/signup_view_controller.dart';
import 'package:veda_nidhi_v2/controllers/toast_controller.dart';

import '../controllers/api_service_controller.dart';
import '../controllers/auth_service_controller.dart';
import '../controllers/contact_us_view_controller.dart';
import '../controllers/edit_profile_controller.dart';
import '../controllers/sub_category_view_controller.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthServiceController(), fenix: true);
    Get.lazyPut(() => ApiServiceController(), fenix: true);
    Get.lazyPut(() => SignUpViewController(), fenix: true);
    Get.lazyPut(() => OnboardingViewController(), fenix: true);
    Get.lazyPut(() => LanguageSelectionViewController(), fenix: true);
    Get.lazyPut(() => NavigationController(), fenix: true);
    Get.lazyPut(() => OtpViewController(), fenix: true);
    Get.lazyPut(() => ToastController(), fenix: true);
    Get.lazyPut(() => ErrorStatusController(), fenix: true);
    Get.lazyPut(() => HomeViewController(), fenix: true);
    Get.lazyPut(() => AboutUsViewController(), fenix: true);
    Get.lazyPut(() => ContactUsViewController(), fenix: true);
    Get.lazyPut(() => SubCategoryViewController(), fenix: true);
    Get.lazyPut(() => ChapterViewScreenController(), fenix: true);
    Get.lazyPut(() => EditProfileController(), fenix: true);
    Get.lazyPut(() => NotificationViewController(), fenix: true);
    Get.lazyPut(() => ProfileViewController(), fenix: true);
    Get.lazyPut(() => NetworkController(), fenix: true);
  }
}
