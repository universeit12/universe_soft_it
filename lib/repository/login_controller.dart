import 'dart:async';
import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';



class LoginController {

  // Private method for sign-in process
  static Future<dynamic> signIn1(dynamic requestBody) async {

    final NetworkResponse response =
    await NetworkCaller.postRequest(url: Urls.loginUrl, body: requestBody);

    return response;
  }












}