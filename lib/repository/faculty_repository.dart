import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';

class FacultyRepository{


  static Future<dynamic> getFaculty() async {

    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.facultyUrl);

    return response;
  }
}