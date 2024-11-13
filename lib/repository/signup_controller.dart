 import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

 import 'package:http/http.dart' as http;
import '../resource/common_widget/toast_message.dart';
import '../resource/constant_string.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();

  final mobileController = TextEditingController();
  final box = GetStorage();

  RxBool isLoading = false.obs;

    String? validateNumber(value) {
    if (value!.isEmpty) {
      return whatsappNumber;
    }
    if (value.length != 11) {
      return elevenDigitNumber;
    }
    return null;
  }
    String? validateName(value) {
      if (value!.isEmpty) {
        return pleaseEnterName;
      }

      return null;
    }
    String? isValidPassword(value) {
      if (value.isEmpty) {
        return pleaseEnterPass;
      }
      return null;
    }



    void registerApi(BuildContext context) async {
      try {
        isLoading.value = true;
        var url = "$baseUrl/registerApp";
        var data = {
          "name": nameController.text,
          "phone": mobileController.text,

        };
        var body = json.encode(data);
        var urlParse = Uri.parse(url);
        var response = await http.post(urlParse,
            body: body, headers: {"Content-Type": "application/json"});

        if(response.statusCode == 200 || response.statusCode == 201){

          isLoading.value = false;
          box.write("login", true);

          Get.offAllNamed('/homeScreen');
          ToastMessage.success(signUpSuccessfully);

        }


      } on SocketException{
        isLoading.value = false;
        ToastMessage.error("No Internet");
      }

      catch (e) {
        isLoading.value = false;
        ToastMessage.error("Something went wrong");
        debugPrint(e.toString());
      }
    }

}