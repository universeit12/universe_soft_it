
import 'package:flutter/material.dart';
import 'package:universe_soft_it/utils/routes/route_name.dart';
import 'package:universe_soft_it/view/all_course_screen.dart';
import 'package:universe_soft_it/view/free_seminar_screen.dart';
import 'package:universe_soft_it/view/login_screen1.dart';
import 'package:universe_soft_it/view/online_admission_screen.dart';
import 'package:universe_soft_it/view/register_screen.dart';
import 'package:universe_soft_it/view/seminar_screen.dart';

import '../../resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import '../../view/splash_screen.dart';



class Routes{


  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen(),);
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen1(),);
      case RouteName.signUpScreen:
        return MaterialPageRoute(builder: (context) => const RegisterScreen(),);
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => const BottomAppBarNavigation(selectedItem: 0,),);
      case RouteName.allPopularCourse:
        return MaterialPageRoute(builder: (context) => const AllPopularCourse(),);
      case RouteName.freeSeminarScreen:
        return MaterialPageRoute(builder: (context) => const FreeSeminarScreen(),);
      case RouteName.onlineAdmission:
        return MaterialPageRoute(builder: (context) => const OnlineAdmission(),);
      case RouteName.seminarScreen:
        return MaterialPageRoute(builder: (context) => SeminarScreen(),);

      default:
        return MaterialPageRoute(builder: (context) => LoginScreen1(),);
    }

  }
}