import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';


class CourseDetailsRepository{


  static Future<dynamic> fetchCourseCategory(courseID) async {

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.courseCategoryUrl(courseID));

    return response;
  }

  static Future<dynamic> fetchCarerObjective(courseID) async {

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.carerObjectiveUrl(courseID));

    return response;
  }

  static Future<dynamic> fetchSemesterWithSpecificCourse(categoryId) async {

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.semesterSpecificCourseUrl(categoryId));

    return response;
  }


}