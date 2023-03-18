import 'dart:async';

import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import '../widgets/snackbars.dart';

class NetworkController extends GetxController {
  var connectionStatus = 0.obs;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult>? subscription;
  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    subscription =
        _connectivity.onConnectivityChanged.listen(updateConnectionStatus);
  }

  int get getStatus => connectionStatus.value;

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
      updateConnectionStatus(result);
    } on PlatformException catch (e) {
      showErrorFromCatch("Platform Error", e);
    }
  }

  updateConnectionStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionStatus.value = 1;
        break;
      case ConnectivityResult.mobile:
        connectionStatus.value = 2;
        break;
      case ConnectivityResult.none:
        connectionStatus.value = 0;
        break;
      case ConnectivityResult.ethernet:
        connectionStatus.value = 3;
        break;
      default:
        break;
    }
  }

  @override
  void onClose() {
    super.onClose();
    if (subscription != null) {
      subscription!.cancel();
    }
  }
}
