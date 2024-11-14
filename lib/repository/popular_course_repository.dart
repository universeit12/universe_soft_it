import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';

class PopularCourseRepository {


  static Future<dynamic> getPopularCourse() async {

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.popularCourseUrl);

    return response;
  }

}