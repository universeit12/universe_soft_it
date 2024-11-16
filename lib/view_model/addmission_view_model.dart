import 'dart:convert';

import 'package:get/get.dart';
import 'package:universe_soft_it/repository/addmission_repository.dart';

import '../models/popular_course_model.dart';
import 'package:http/http.dart' as http;

import '../resource/constant_string.dart';
import '../resource/urls.dart';

class AddmissionViewModel extends GetxController{

  final RxBool _inProgress = false.obs;
  final RxBool _isSuccess = false.obs;
  final RxString _errorMessage = ''.obs;


  // Public getters
  bool get inProgress => _inProgress.value;
  bool get isSuccess => _isSuccess.value;
  String get errorMessage => _errorMessage.value;

  var course = <PopularCourseModel>[].obs;
  var selectedCourse = Rxn<PopularCourseModel>();
  final genderTypeList = ["Select Gender", "Male", "Female"];



  String selectedVal = "";
  String? selectedGenderVal;

  // Reset methods
  void resetSelectedCourse() {
    selectedCourse.value = null;
  }

  void resetSelectedGender() {
    selectedGenderVal = null;
    update(); // Notify listeners for non-reactive fields like String
  }


  Future<bool> postAddmissionRequest({name,email,course,gender,contact,address,website}) async {
    _inProgress.value = true;
    Map<String, dynamic> requestBody = {
      "name": name,
      "email": email,
      "course": course,
      "gender": gender,
      "contact": contact,
      "address": address,
      "website": website

    };

    final dynamic response = await AddmissionRepository.postAddmissionRequest(requestBody);

    if (response.isSuccess) {
      _isSuccess.value = true;

    } else {
      _errorMessage.value = response.errorMessage ?? 'Unknown error';
      _isSuccess.value = false;
    }
    _inProgress.value = false;
    return _isSuccess.value;
  }



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
    final response = await http.get(Uri.parse(Urls.popularCourseUrl));
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