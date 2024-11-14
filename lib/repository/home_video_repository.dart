import 'dart:async';
import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';



class HomeVideoRepository {


  static Future<dynamic> homeContentVideo() async {

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.homeVideoUrl);

    return response;
  }

}