import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:universe_soft_it/argument/course_argument.dart';

import 'package:universe_soft_it/details/course_details.dart';
import 'package:universe_soft_it/profile_screen.dart';
import 'package:universe_soft_it/routes/routes_name.dart';

import 'package:universe_soft_it/presentation/home/view/home_screen.dart';
import 'package:universe_soft_it/presentation/login/view/login_screen.dart';
import 'package:universe_soft_it/presentation/splashScreen/view/splash_screen.dart';
import 'package:universe_soft_it/widget/all_course.dart';



import 'presentation/free_seminar/view/free_seminar_screen.dart';

import 'presentation/addmission/view/online_admission_screen.dart';
import 'presentation/seminar/view/seminar_screen.dart';

Future<void> main() async {
  // Initialization for get storage
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),

        routes: {
          RouteName.intro:(context)=> const SplashScreen(),
          RouteName.courseHome:(context)=> const HomeScreen(),
          RouteName.loginScreen:(context)=>  LoginScreen(),
          RouteName.allPopularCourse:(context)=> const AllPopularCourse(),
          RouteName.seminarScreen:(context)=>   SeminarScreen(),
          RouteName.onlineAdmission:(context)=> const OnlineAdmission(),
          RouteName.freeSeminarScreen:(context)=>  const FreeSeminarScreen(),
          RouteName.profileScreen:(context)=>   ProfilePage(token: '',),
        },

         onGenerateRoute: (setting){

          if(setting.name == RouteName.detailScreen){

            final args = setting.arguments as CourseArgument;
            return MaterialPageRoute(builder: (context) => CourseDetails(course: args.course),);

          }
          return null;



        },
      ),
    );
  }
}


