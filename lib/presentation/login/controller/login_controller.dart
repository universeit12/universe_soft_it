import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


import 'package:universe_soft_it/routes/routes_name.dart';

import '../../home/view/home_screen.dart';
import '../../../widget/toast_message.dart';


class LoginController extends GetxController{

  RxBool isLoading = false.obs;
  RxBool isChecked = false.obs;

  final mobileController = TextEditingController();
  final passController = TextEditingController();
  final box = GetStorage();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void onInit() {
    _startFeatch;
    super.onInit();
  }


  String? validateNumber(value) {
    if (value!.isEmpty) {
      return "Please enter a whatsapp/phone number";
    }
    if (value.length != 11) {
      return "Please enter a 11 digit phone number";
    }
    return null;
  }

  String? isValidPassword(value) {
    // Define the regex for the required criteria


    // Check if the password matches the pattern
    if (value.isEmpty) {
      return "Please enter password";
    }
  }


  void _startFeatch() {
    Timer(const Duration(seconds: 2), () {
      if(box.read("lastScreen")??false){
        debugPrint("LastScreen already seen");
        Get.offAllNamed(RouteName.courseHome);

      }
      else{
        debugPrint("LastScreen dont seen");
      }
    });
  }
  loginApi( context) async {

      try {
        var url = "https://bifdt-server-ashikur.vercel.app/login";
        var data = {

          "phone": mobileController.text,
          "password": passController.text
        };
        var body = json.encode(data);
        var urlParse = Uri.parse(url);
        var response = await http.post(urlParse,
            body: body, headers: {"Content-Type": "application/json"});
        var data2 = jsonDecode(response.body);


        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
        ToastMessage.success("Login Successfully");



      } catch (e) {
        ToastMessage.error("Please input valid number & password");

      }


  }



}