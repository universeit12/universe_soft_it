import 'dart:async';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../repository/login_controller.dart';



class LoginViewModel extends GetxController{




  final RxBool _inProgress = false.obs;
  final RxBool _isSuccess = false.obs;
  final RxString _errorMessage = ''.obs;
  final box = GetStorage();

  // Public getters
  bool get inProgress => _inProgress.value;
  bool get isSuccess => _isSuccess.value;
  String get errorMessage => _errorMessage.value;

  // Private method for sign-in process
  Future<bool> signIn(number) async {
    _inProgress.value = true;
    Map<String, dynamic> requestBody = {"phone": number,};

    final dynamic response = await LoginController.signIn1(requestBody);

    if (response.isSuccess) {
      _isSuccess.value = true;
      box.write("login", true);
    } else {
      _errorMessage.value = response.errorMessage ?? 'Unknown error';
      _isSuccess.value = false;
    }
    _inProgress.value = false;
    return _isSuccess.value;
  }












}