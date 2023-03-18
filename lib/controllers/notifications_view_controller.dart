import 'package:get/get.dart';
import 'package:veda_nidhi_v2/controllers/api_service_controller.dart';

import '../models/notification_model.dart';

class NotificationViewController extends GetxController {
  final _apiClient = Get.find<ApiServiceController>();

  Future<NotificationModel> getNotifications() async {
    final res = await _apiClient.fetchData(
        fetchUrl: "items/notifications?fields[]=*.*");

    final model = notificationModelFromMap(res.toString());
    return model;
  }
}
