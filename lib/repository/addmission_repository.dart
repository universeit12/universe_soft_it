import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';

class AddmissionRepository{

  static Future<dynamic> postAddmissionRequest(requestBody) async {

    final NetworkResponse response = await NetworkCaller.postRequest(url: Urls.addmissionUrl,body: requestBody);

    return response;
  }

}