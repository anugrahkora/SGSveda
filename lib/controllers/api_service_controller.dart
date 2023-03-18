// ignore_for_file: invalid_return_type_for_catch_error

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:veda_nidhi_v2/controllers/auth_service_controller.dart';
import 'package:veda_nidhi_v2/utils/error_utils.dart';
import 'package:dio/dio.dart' as d;

import '../utils/constants.dart';

class ApiServiceController extends GetxController with ErrorUtils {
  final _authController = Get.find<AuthServiceController>();

  final _dio = d.Dio(
    d.BaseOptions(
      connectTimeout: 50000,
      receiveTimeout: 30000,
    ),
  );
  ApiServiceController() {
    _dio.interceptors.clear();
    // _dio.interceptors.add(d.LogInterceptor());
    _dio.interceptors.add(
      d.QueuedInterceptorsWrapper(
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onRequest: ((options, handler) {
          if (_authController.refreshToken.value != null &&
              _authController.refreshToken.value != '') {
            options.headers['Authorization'] =
                "Bearer ${_authController.accessToken.value}";
          }
          return handler.next(options);
        }),
        onError: (error, handler) async {
          if (error.response?.statusCode == 403 ||
              error.response?.statusCode == 401 ||
              _authController.accessToken.value != null ||
              JwtDecoder.isExpired(_authController.accessToken.value!)) {
            var res = await _authController.getNewTokens();

            if (res) {
              error.requestOptions.headers["Authorization"] =
                  "Bearer ${_authController.accessToken.value}";
              final options = d.Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers);
              final cloneReq = await _dio.request(error.requestOptions.path,
                  options: options,
                  data: error.requestOptions.data,
                  queryParameters: error.requestOptions.queryParameters);

              return handler.resolve(cloneReq);
            }
          } else {
            handler.reject(error);
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<dynamic> fetchData({required String fetchUrl}) async {
    final url = "$baseUrl/$fetchUrl";
    dynamic res;

    var response = await _dio
        .get(
          url,
        )
        .catchError(handleError)
        .timeout(
          const Duration(seconds: timeOutDuration),
        );

    if (response.statusCode == 200 && response.data["data"] != null) {
      res = response;

      return res;
    }

    return res;
  }

  Future<dynamic> postData(
      {required String postUrl, required dynamic data}) async {
    String url = "$baseUrl/$postUrl";
    dynamic res;

    var response = await _dio
        .post(
          url,
          data: data,
          options: d.Options(headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer ${_authController.accessToken.value}",
          }),
        )
        .catchError(handleError)
        .timeout(
          const Duration(seconds: timeOutDuration),
        );

    if (response.statusCode == 200) {
      res = response;

      return res;
    }

    return res;
  }

  Future<dynamic> patchData(
      {required String patchUrl, required dynamic data}) async {
    final url = "$baseUrl/$patchUrl";

    dynamic res;

    var response = await _dio
        .patch(
          url,
          data: data,
          options: d.Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer ${_authController.accessToken.value}",
            },
          ),
        )
        .catchError(handleError)
        .timeout(
          const Duration(seconds: timeOutDuration),
        );

    if (response.statusCode == 200) {
      res = response;

      return res;
    }

    return res;
  }
}
