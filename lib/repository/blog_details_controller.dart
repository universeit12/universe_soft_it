import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../resource/common_widget/toast_message.dart';
import 'package:http/http.dart' as http;

import '../resource/constant_string.dart';

class BlogDetailsController extends GetxController{

  final nameController = TextEditingController().obs;
  final commentController = TextEditingController().obs;
  final contactController = TextEditingController().obs;

  final nameFocusNode = FocusNode().obs;
  final numberFocusNode = FocusNode().obs;
  final commentFocusNode = FocusNode().obs;

  RxBool isLoading = false.obs;



  void blogCommentApi() async {
    try {
      isLoading.value = true;
      var url = "$baseUrl/comments";
      var data = {
        "name": nameController.value.text,
        "comment": commentController.value.text,
        "contactNumber": contactController.value.text

      };
      var body = json.encode(data);
      var urlParse = Uri.parse(url);
      var response = await http.post(urlParse,
          body: body, headers: {"Content-Type": "application/json"});

      if(response.statusCode == 200 || response.statusCode == 201){
        isLoading.value = false;
        debugPrint(response.body.toString());
        debugPrint(response.statusCode.toString());
        nameController.value.clear();
        contactController.value.clear();
        commentController.value.clear();


        ToastMessage.success("Comment Successfully");

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