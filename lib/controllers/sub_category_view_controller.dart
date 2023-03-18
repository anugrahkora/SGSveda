import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/api_service_controller.dart';

import '../models/get_sub_category_model.dart';

class SubCategoryViewController extends GetxController {
  final _apiClient = Get.find<ApiServiceController>();

  Future<GetSubCategoryModel> getSubCategory(String id) async {
    final res = await _apiClient.fetchData(
        fetchUrl:
            'items/sub_categories?filter={"categories":{"_eq":"$id"}}&sort[]=rank');
    final model = getSubCategoryModelFromMap(res.toString());
    return model;
  }


}
