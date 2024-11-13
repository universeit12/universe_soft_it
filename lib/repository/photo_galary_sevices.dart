import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:universe_soft_it/models/photo_galary_model.dart';


class PhotoGalleryService {
  final String apiUrl = "https://bifdt-server-ashikur.vercel.app/studentGallery";

  Future<List<PhotoGalaryImage>> fetchGalleryImages() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => PhotoGalaryImage.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}
