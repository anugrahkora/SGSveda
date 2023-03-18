import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/toast_controller.dart';
import '../utils/constants.dart';

final toastController = Get.find<ToastController>();

showErrorFromCatch(String message, Object e) {
  if (toastController.counter.value <= 2) {
    toastController.updateCounter();
    return Get.snackbar(
      duration: snackBarDuration,
      message,
      e.toString(),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }
}

showErrorFromFirebase(String message, FirebaseAuthException e) {
  if (toastController.counter.value <= 2) {
    toastController.updateCounter();
    return Get.snackbar(
      duration: snackBarDuration,
      message,
      e.message.toString(),
      icon: const Icon(Icons.error, color: Colors.white),
    );
  }
}

showCodeSentSnackbar() {
  return Get.snackbar(
    duration: snackBarDuration,
    'Sent',
    'Code Has been sent to you number',
    icon: const Icon(Icons.done, color: Colors.white),
    backgroundColor: Colors.greenAccent,
  );
}

showBasicSnackbar(String message) {
  if (toastController.counter.value <= 2) {
    toastController.updateCounter();
    return Get.snackbar(
      duration: snackBarDuration,
      message,
      '',
    );
  }
}

showBasicSnackbarExtended(String message, String body) {
  if (toastController.counter.value <= 2) {
    toastController.updateCounter();
    return Get.snackbar(
      duration: snackBarDuration,
      message,
      body,
    );
  }
}

showBasicSnackbarWithoutCounter(String message) {
  return Get.snackbar(
    duration: snackBarDuration,
    message,
    '',
  );
}

showErrorFromDio(String message, DioError e) {
  if (toastController.counter.value <= 2) {
    toastController.updateCounter();
    if (e.type == DioErrorType.other && e.error is SocketException) {
      toastController.counter.value = 4;
      return Get.snackbar(
        duration: snackBarDuration,
        'No Internet',
        "Please Check your network connection",
        icon: const Icon(Icons.error, color: Colors.white),
      );
    }
    if (e.type == DioErrorType.other && e.error is TimeoutException) {
      return showBasicSnackbar('Connection time out');
    } else {
      return showBasicSnackbar(
      
        message,
       
        
      );
    }
  }
}

showSuccess(String message, String subTitle) {
  return Get.snackbar(
    duration: snackBarDuration,
    message,
    subTitle,
    icon: const Icon(Icons.done, color: Colors.white),
    backgroundColor: Colors.greenAccent,
  );
}

showWarning(String message, String subTitle) {
  return Get.snackbar(
    duration: snackBarDuration,
    message,
    subTitle,
    icon: const Icon(Icons.warning, color: Colors.black),
    backgroundColor: Colors.amber,
  );
}
