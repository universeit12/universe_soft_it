

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ToastMessage {
  static success(String message) {
    return Get.snackbar('Success', message,
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  static error(String message) {
    return Get.snackbar('Alert', message,
        backgroundColor: Colors.red, colorText: Colors.white);
  }


  static otP(String message) {
    return Get.snackbar('OTP CODE', message,
        backgroundColor: Colors.black, colorText: Colors.white, duration: const Duration(seconds: 5));

  }
}