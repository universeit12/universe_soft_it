import 'dart:convert';

import 'package:get/get.dart';

import '../models/faculty_model.dart';
import 'package:http/http.dart' as http;

import '../resource/constant_string.dart';

class FacultyController extends GetxController{

  RxList  facultyMember= [].obs;
  Future<RxList> getData()async{
    final response = await http.get(Uri.parse("$baseUrl/faculty"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        facultyMember.add(FacultyMemberModel.fromJson(index));
      }
      return facultyMember;
    }
    else{
      return facultyMember;
    }
  }
}