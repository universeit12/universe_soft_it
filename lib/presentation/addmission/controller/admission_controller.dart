

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdmissionController extends GetxController{
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final numberController = TextEditingController();
  final addressController = TextEditingController();
  final aboutWebsiteController = TextEditingController();

  final courseList = [
    "Select Course",
    "Fashion Design",
    "Merchandising",
    "Pattern Design",
    "Graphics & Web Design",
    "Interior Design",
    "Leather Design",
    "Computer Operator"
  ];



  final genderTypeList = ["Select Gender", "Male", "Female"];

  String selectedGenderVal = "";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? validateEmail(value) {
    if (value!.isEmpty) {
      return "Please enter an email";
    }
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegExp.hasMatch(value)) {
      return "Please enter a valid email";
    }
    return null;
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

}
