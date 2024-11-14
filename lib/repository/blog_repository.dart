import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';

class BlogRepository{


  static Future<dynamic> getBlog() async {

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.blogUrl);

    return response;
  }


}