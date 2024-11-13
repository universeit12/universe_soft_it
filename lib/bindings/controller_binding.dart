import 'package:get/get.dart';
import 'package:universe_soft_it/view_model/login_view_model.dart';



class ControllerBinders extends Bindings{
  @override
  void dependencies() {
    Get.put(LoginViewModel());


  }

}