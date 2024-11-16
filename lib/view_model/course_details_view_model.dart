
import 'dart:convert';

import 'package:get/get.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:http/http.dart' as http;
import 'package:share_plus/share_plus.dart';
import 'package:universe_soft_it/repository/course_details_repository.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../models/carrer_objective_model.dart';
import '../models/course_category_model.dart';
import '../models/course_semister_model.dart';
import '../models/popular_course_model.dart';
import '../resource/constant_string.dart';

class CourseDetailsViewModel extends GetxController{
  final PopularCourseModel course;

  CourseDetailsViewModel(this.course);

  final RxBool _inProgress = false.obs;
  final RxBool _isSuccess = false.obs;
  final RxString _errorMessage = ''.obs;

  // Public getters
  bool get inProgress => _inProgress.value;
  bool get isSuccess => _isSuccess.value;

  var videoId = ''.obs;
  var extractedText = ''.obs;
  var extractedText2 = ''.obs;

  var carerObjectiveList = <CarrerObjectiveModel>[].obs;
  var courseCategory = <CourseCategoryModel>[].obs;
  var semesterCategory = <CourseSemesterModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    extractTextFromHtml(course.admissionNotice.toString(), extractedText);
    extractTextFromHtml(course.bangla.toString(), extractedText2);
    videoId.value = YoutubePlayer.convertUrlToId(course.videoUrl.toString()) ?? '';
    fetchCourseCategory();
    fetchCarrerObjective();

  }

  void extractTextFromHtml(String htmlString, RxString target) {
    dom.Document document = html_parser.parse(htmlString);
    target.value = document.body?.text ?? '';
  }

 

  Future<void> fetchCourseCategory() async {
    courseCategory.clear();
    _inProgress.value = true;
    update();

    final dynamic response = await CourseDetailsRepository.fetchCourseCategory(course.sId.toString());

    if (response.isSuccess) {
      final List<dynamic> data = response.responseData;

      courseCategory.addAll(
          data.map((item) => CourseCategoryModel.fromJson(item)).toList()
      );
       // Update showingProduct
      _isSuccess.value = true;
    } else {
      _errorMessage.value = response.errorMessage ?? 'Unknown error';
      _isSuccess.value = false;
    }
    _inProgress.value = false;
    update();

  }

  Future<void> fetchCarrerObjective() async {
    carerObjectiveList.clear();
    _inProgress.value = true;
    update();

    final dynamic response = await CourseDetailsRepository.fetchCarerObjective(course.sId.toString());

    if (response.isSuccess) {
      final List<dynamic> data = response.responseData;

      carerObjectiveList.addAll(
          data.map((item) => CarrerObjectiveModel.fromJson(item)).toList()
      );
      // Update showingProduct
      _isSuccess.value = true;
    } else {
      _errorMessage.value = response.errorMessage ?? 'Unknown error';
      _isSuccess.value = false;
    }
    _inProgress.value = false;
    update();

  }

  Future<void> fetchSemesterWithSpecificCourse(categoryId) async {
    semesterCategory.clear();
    _inProgress.value = true;
    update();

    final dynamic response = await CourseDetailsRepository.fetchCourseCategory(categoryId);

    if (response.isSuccess) {
      final List<dynamic> data = response.responseData;

      semesterCategory.addAll(
          data.map((item) => CourseSemesterModel.fromJson(item)).toList()
      );
      // Update showingProduct
      _isSuccess.value = true;
    } else {
      _errorMessage.value = response.errorMessage ?? 'Unknown error';
      _isSuccess.value = false;
    }
    _inProgress.value = false;
    update();

  }


  void shareCourseDetails() {
    final shareText = """
Course Title: ${course.title}
Description: ${course.description?.replaceAll(RegExp(r'<[^>]*>'), '')}
Watch the course video on YouTube: ${course.videoUrl}
For More Details Visit Our Website: https://bifdt.info/
""";
    Share.share(shareText);
  }


}