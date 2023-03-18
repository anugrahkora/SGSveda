import 'package:get/get.dart';

import '../models/get_chapters_model.dart';
import '../models/user_model.dart';
import 'api_service_controller.dart';

class ChapterViewScreenController extends GetxController {
  final _apiClient = Get.find<ApiServiceController>();

  Future<GetChaptersModel> getChapters(String id) async {
    final res = await _apiClient.fetchData(
        fetchUrl:
            'items/chapters?fields[]=*.*&filter={"sub_categories": {"_eq": "$id"}}&sort[]=rank');
  

    final model = getChaptersModelFromMap(res.toString());
    return model;
  }

  Future<UserModel> getUserData() async {
    final res = await _apiClient.fetchData(fetchUrl: "users/me");

    return userModelFromMap(res.toString());
  }
}
