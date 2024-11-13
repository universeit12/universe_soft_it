

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/popular_course_model.dart';
import '../resource/constant_string.dart';

class AdmissionController extends GetxController{
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  final numberController = TextEditingController().obs;
  final addressController = TextEditingController().obs;
  final aboutWebsiteController = TextEditingController().obs;



  RxBool isloading = false.obs;

  var course = <PopularCourseModel>[].obs;
  var selectedCourse = Rxn<PopularCourseModel>();

  final courseList = [
    selectCourse,
    fashionDesign,
    merchandising,
    patternDesign,
    graphicsWebDesign,
    interiorDesign,
    leatherDesign,
    computerOperator
  ];



  final genderTypeList = [selectGender, male, female];

  String selectedGenderVal = "";



  String? validateEmail(value) {
    if (value!.isEmpty) {
      return pleaseEnterEmail;
    }
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if (!emailRegExp.hasMatch(value)) {
      return pleaseEnterValidEmail;
    }
    return null;
  }

  String? validateNumber(value) {
    if (value!.isEmpty) {
      return whatsappNumber;
    }
    if (value.length != 11) {
      return elevenDigitNumber;
    }
    return null;
  }

  @override
  void onInit() {
    super.onInit();
    fetchCourseName();

  }

  void fetchCourseName() async {
    final response = await http.get(Uri.parse('$baseUrl/course'));
    if (response.statusCode == 200) {
      var divisionData = json.decode(response.body);
      course.value = (divisionData as List).map((e) => PopularCourseModel.fromJson(e)).toList();
    } else {
      Get.snackbar('Error', 'Failed to load divisions');
    }
  }

  void onCourseSelected(PopularCourseModel? type) {
    selectedCourse.value = type;
  }

}
