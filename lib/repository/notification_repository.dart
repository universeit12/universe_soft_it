import '../data/network_caller/network_caller.dart';
import '../models/network_response.dart';
import '../resource/urls.dart';

class NotificationRepository {

  static Future<dynamic> getNotification() async {

    final NetworkResponse response = await NetworkCaller.getRequest(url:Urls.notificationUrl);

    return response;
  }


}