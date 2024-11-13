
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../models/carrer_objective_model.dart';
import '../models/course_category_model.dart';

import '../models/course_semister_model.dart';

class CourseDetailsController extends GetxController{

  var careerObjective = <CarrerObjectiveModel>[];
  var courseCategory = <CourseCategoryModel>[];
  var courseSemester = <CourseSemesterModel>[];




  void fetchCourseCategory(courseId) async {
    final response = await http.get(Uri.parse('https://bifdt-server-ashikur.vercel.app/objectives/course/$courseId'));
    if (response.statusCode == 200) {
      var districtData = json.decode(response.body);

        courseCategory = (districtData as List).map((e) => CourseCategoryModel.fromJson(e)).toList();

    } else {
      Get.snackbar('Error', 'Failed to load course categories');
    }
  }

  void fetchCourseSemester(courseCategoryId) async {
    final response = await http.get(Uri.parse('https://bifdt-server-ashikur.vercel.app/semesterByCourse/course/$courseCategoryId'));
    if (response.statusCode == 200) {
      var districtData = json.decode(response.body);

        courseSemester = (districtData as List).map((e) => CourseSemesterModel.fromJson(e)).toList();

    } else {
      Get.snackbar('Error', 'Failed to load course semesters');
    }
  }
}