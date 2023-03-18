import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:veda_nidhi_v2/widgets/snackbars.dart';

class ErrorUtils {
  void handleError(error) {
    if (error is SocketException) {
      showBasicSnackbarExtended(
          'Network Error', "Please check your network connection");
    } else if (error is DioError) {
      showErrorFromDio('Network Error', error);
    } else if (error is TimeoutException) {
      showBasicSnackbarExtended(
          'Connection Time Out', "Please check your network connection");
    } else {
      showBasicSnackbarExtended('Unknown Error', error);
    }
  }
}
