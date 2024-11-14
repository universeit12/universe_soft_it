import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';

class FreeSeminarRepository {


  static Future<dynamic> postFreeSeminar(requestBody) async {

    var freeSeminarUrl;
    final NetworkResponse response = await NetworkCaller.postRequest(url: Urls.freeSeminarUrl,body: requestBody);

    return response;
  }

}