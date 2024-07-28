import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/seminar_model.dart';

class SeminarController extends GetxController{
  RxList  seminar= [].obs;
  Future<RxList> getData()async{

    final response = await http.get(Uri.parse("https://bifdt-server-ashikur.vercel.app/seminar"));

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