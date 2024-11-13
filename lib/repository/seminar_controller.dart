import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../models/seminar_model.dart';
import '../resource/constant_string.dart';

class SeminarController extends GetxController{
  RxList  seminar= [].obs;
  Future<RxList> getData()async{
    seminar.clear();

    final response = await http.get(Uri.parse("$baseUrl/seminar"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        seminar.add(SeminarModel.fromJson(index));
      }
      return seminar;
    }
    else{
      return seminar;
    }


  }
}