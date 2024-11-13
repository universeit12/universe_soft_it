import 'dart:convert';

import 'package:get/get.dart';

import '../models/blog_model.dart';
import 'package:http/http.dart' as http;

import '../resource/constant_string.dart';

class BlogController extends GetxController{
  RxList  blogList= [].obs;


  Future<RxList> getData()async{

    final response = await http.get(Uri.parse("$baseUrl/blog"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        blogList.add(BlogModel.fromJson(index));
      }
      return blogList;
    }
    else{
      return blogList;
    }


  }
}