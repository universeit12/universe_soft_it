import 'dart:convert';

import 'package:get/get.dart';

import 'package:http/http.dart' as http;

import '../model/popular_course_model.dart';

class PopularCourseController extends GetxController{
  RxList popularCourseList =[].obs;

  Future<RxList> getData()async{
    final response = await http.get(Uri.parse("https://bifdt-server-ashikur.vercel.app/course"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        popularCourseList.add(PopularCourseModel.fromJson(index));
      }
      return popularCourseList;
    }
    else{
      return popularCourseList;
    }
  }
}