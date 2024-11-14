import 'package:get/get.dart';
import 'package:universe_soft_it/view_model/login_view_model.dart';
import 'package:universe_soft_it/view_model/register_view_model.dart';

import '../view_model/addmission_view_model.dart';
import '../view_model/blog_view_model.dart';
import '../view_model/free_seminar_view_model.dart';
import '../view_model/home_content_view_model.dart';
import '../view_model/popular_course_view_model.dart';




class ControllerBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginViewModel());
    Get.put(RegisterViewModel());
    Get.put(HomeContentViewModel());
    Get.put(PopularCourseViewModel());
    Get.put(BlogViewModel());
    Get.put(FreeSeminarViewModel());
    Get.put(AddmissionViewModel());


  }

}