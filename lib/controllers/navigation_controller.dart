import 'package:get/get.dart';

class NavigationController extends GetxController {
  RxInt tabIndex = 0.obs;
  int get tab => tabIndex.value;
  void setTab(int index) {
    tabIndex.value = index;
  }
}
