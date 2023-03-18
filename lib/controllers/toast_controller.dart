import 'package:get/get.dart';

class ToastController extends GetxController {
  var counter = 0.obs;

  updateCounter() {
    counter.value = counter.value + 1;
  }
}
