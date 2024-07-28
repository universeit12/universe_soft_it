import 'dart:convert';

import 'package:get/get.dart';

import '../model/blog_model.dart';
import 'package:http/http.dart' as http;

class BlogController extends GetxController{
  RxList  blogList= [].obs;


  Future<RxList> getData()async{

    final response = await http.get(Uri.parse("https://bifdt-server-ashikur.vercel.app/blog"));

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