import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/api_service_controller.dart';

import '../models/about_us_model.dart';

class AboutUsViewController extends GetxController {
  final _apiClient = Get.find<ApiServiceController>();
RxInt carouselIndex = 0.obs;
  int get index => carouselIndex.value;
  void setCarouselIndex(int index) {
    carouselIndex.value = index;
  }
  Future<GetAboutUsModel> getAboutUs() async {
    final res = await _apiClient.fetchData(
        fetchUrl: "items/about_page?fields=*,banners.directus_files_id");
    final model = getAboutUsModelFromMap(res.toString());
    return model;
  }
}
