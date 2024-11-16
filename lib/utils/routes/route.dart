import 'package:flutter/material.dart';
import 'package:universe_soft_it/utils/routes/route_name.dart';
import 'package:universe_soft_it/view/all_course_screen.dart';
import 'package:universe_soft_it/view/all_faculty_screen.dart';
import 'package:universe_soft_it/view/free_seminar_screen.dart';
import 'package:universe_soft_it/view/home_screen.dart';
import 'package:universe_soft_it/view/login_screen1.dart';
import 'package:universe_soft_it/view/online_admission_screen.dart';
import 'package:universe_soft_it/view/register_screen.dart';
import 'package:universe_soft_it/view/seminar_screen.dart';
import '../../view/all_blog_screen.dart';
import '../../view/splash_screen.dart';



class Routes{


  static Route<dynamic> generateRoute(RouteSettings settings){

    switch(settings.name){
      case RouteName.splashScreen:
        return MaterialPageRoute(builder: (context) => const SplashScreen(),);
      case RouteName.loginScreen:
        return MaterialPageRoute(builder: (context) => LoginScreen1(),);
      case RouteName.signUpScreen:
        return MaterialPageRoute(builder: (context) =>  RegisterScreen(),);
      case RouteName.homeScreen:
        return MaterialPageRoute(builder: (context) => const HomeScreen());
      case RouteName.allPopularCourse:
        return MaterialPageRoute(builder: (context) => const AllPopularCourse(),);
      case RouteName.allBlogScreen:
        return MaterialPageRoute(builder: (context) => const AllBlog(),);
      case RouteName.allFacultyScreen:
        return MaterialPageRoute(builder: (context) => const AllFacultyMember(),);
      case RouteName.freeSeminarScreen:
        return MaterialPageRoute(builder: (context) => FreeSeminarScreen(),);
      case RouteName.onlineAdmission:
        return MaterialPageRoute(builder: (context) =>  OnlineAdmission(),);
      case RouteName.seminarScreen:
        return MaterialPageRoute(builder: (context) => SeminarScreen(),);

      default:
        return MaterialPageRoute(builder: (context) => LoginScreen1(),);
    }

  }
}