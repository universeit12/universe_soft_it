 import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/constant/constant_string.dart';
 import 'package:http/http.dart' as http;

import '../../../widget/toast_message.dart';
import '../../login/view/login_screen.dart';

class SignUpController extends GetxController {
  final nameController = TextEditingController();
  final passController = TextEditingController();
  final mobileController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
        var url = "https://bifdt-server-ashikur.vercel.app/register";
        var data = {
          "name": nameController.text,
          "phone": mobileController.text,
          "password": passController.text
        };
        var body = json.encode(data);
        var urlParse = Uri.parse(url);
        var response = await http.post(urlParse,
            body: body, headers: {"Content-Type": "application/json"});



        ToastMessage.success("SignUp Successfully");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen(),));
      } catch (e) {
        ToastMessage.error("Please input valid number & password");
      }
    }

}