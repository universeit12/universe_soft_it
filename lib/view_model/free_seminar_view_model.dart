import 'dart:convert';

import 'package:get/get.dart';
import 'package:universe_soft_it/repository/free_seminar_repository.dart';
import 'package:universe_soft_it/resource/urls.dart';

import '../models/popular_course_model.dart';
import '../resource/constant_string.dart';
import 'package:http/http.dart' as http;

class FreeSeminarViewModel extends GetxController{

  final RxBool _inProgress = false.obs;
  final RxBool _isSuccess = false.obs;
  final RxString _errorMessage = ''.obs;


  // Public getters
  bool get inProgress => _inProgress.value;
  bool get isSuccess => _isSuccess.value;
  String get errorMessage => _errorMessage.value;

  var course = <PopularCourseModel>[].obs;
  var selectedCourse = Rxn<PopularCourseModel>();

  freeSeminarScreenState(){
    selectedVal = courseList[0] ;
    selectedTypeVal = courseTypeList[0] ;

  }
  String selectedVal = "";
  String selectedTypeVal = "";

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


  final courseTypeList = [
    selectSegment,
    onlineSegment,
    offlineSegment,

  ].obs;

  void onCourseSelected(PopularCourseModel? type) {
    selectedCourse.value = type;
  }

  @override
  void onInit() {
    super.onInit();
    fetchCourseName();

  }


  Future<bool> postFreeSeminar({name,email,course, whatsapp}) async {
    _inProgress.value = true;
    Map<String, dynamic> requestBody = {
      "name":name,
      "email": email,
      "course": course,
      "whatsapp": whatsapp,
      "segment" :selectedTypeVal.toString()

    };

    final dynamic response = await FreeSeminarRepository.postFreeSeminar(requestBody);

    if (response.isSuccess) {
      _isSuccess.value = true;

    } else {
      _errorMessage.value = response.errorMessage ?? 'Unknown error';
      _isSuccess.value = false;
    }
    _inProgress.value = false;
    return _isSuccess.value;
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

  String? validateEmail(value){
    if(value!.isEmpty){
      return pleaseEnterEmail;

    }
    RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    if(!emailRegExp.hasMatch(value)){
      return pleaseEnterValidEmail;

    }
    return null;

  }

  String? validateNumber(value){
    if(value!.isEmpty){
      return whatsappNumber;

    }
    if(value.length != 11){

      return elevenDigitNumber;

    }
    return null;

  }
  void updateSelectedTypeVal(String value) {
    selectedTypeVal = value;
  }


}