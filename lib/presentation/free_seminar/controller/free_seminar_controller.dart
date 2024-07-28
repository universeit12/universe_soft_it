import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FreeSeminarController extends GetxController{

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();

  final courseList = [
    "Select Course",
    "Fashion Design",
    "Merchandising",
    "Pattern Design",
    "Graphics & Web Design",
    "Interior Design",
    "Leather Design",
    "Computer Operator"].obs;



  final courseTypeList = [
    "Select Segment",
    "Online Segment",
    "Offline Segment",

  ].obs;



  RxBool isLoading = false.obs;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  String? validateEmail(value){
    if(value!.isEmpty){
      return "Please enter an email";

    }
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if(!emailRegExp.hasMatch(value)){
      return "Please enter a valid email";

    }
    return null;

  }

  String? validateNumber(value){
    if(value!.isEmpty){
      return "Please enter a whatsapp/phone number";

    }
    if(value.length != 10){

      return "Please enter a 10 digit phone number";

    }
    return null;

  }
}