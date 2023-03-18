import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/api_service_controller.dart';
import 'package:veda_nidhi_v2/models/user_model.dart';

class ProfileViewController extends GetxController {
  final _apiClient = Get.find<ApiServiceController>();

  Future<UserModel> getUserData() async {
    final res = await _apiClient.fetchData(fetchUrl: "users/me");

    return userModelFromMap(res.toString());

  }
}
