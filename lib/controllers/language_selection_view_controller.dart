import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/api_service_controller.dart';
import 'package:veda_nidhi_v2/utils/language_utils.dart';
import 'package:veda_nidhi_v2/utils/shared_prefs.dart';
class LanguageSelectionViewController extends GetxController {
  final _apiClient = Get.find<ApiServiceController>();
  RxInt selectedLanguageIndex = 0.obs;
  RxBool buttonLoading = false.obs;

  int get language => selectedLanguageIndex.value;
  bool get isLoading => buttonLoading.value;
  changeLanguage(int index) {
    selectedLanguageIndex.value = index;
  }

  Future<dynamic> saveLanguage() async {
    dynamic res;
    setLoading(true);
    final data = {"language": languages[language]};
    res = await _apiClient.patchData(patchUrl: 'users/me', data: data);
    await SharedPref.setNewUser(false);
    setLoading(false);
    Get.close(2);

    return res;
  }

  void setLoading(bool val) {
    buttonLoading.value = val;
  }
}
