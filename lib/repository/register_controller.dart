import 'dart:async';
import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';



class RegisterController {


  static Future<dynamic> register(dynamic requestBody) async {

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.registerUrl, body: requestBody);

    return response;
  }

}