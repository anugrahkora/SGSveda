import 'package:get/get.dart';

class ErrorStatusController extends GetxController {
  RxString errorText = ''.obs;
  String get error => errorText.value;
  void setError(String val) {
    errorText.value = val;
  }
  void clearError() {
    errorText.value = "";
  }
}
