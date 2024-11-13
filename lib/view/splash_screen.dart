

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:universe_soft_it/resource/common_widget/screen_background.dart';

import '../resource/image_path_string.dart';





class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();


  @override
  void initState() {
    bool? isLogin = box.read("login");
    // TODO: implement initState
    super.initState();

    if(isLogin == true){
      Timer( const Duration(seconds: 3), () {

        Navigator.pushReplacementNamed(context, '/homeScreen');
      });

    }else{
      Timer( const Duration(seconds: 3), () {

        Navigator.pushReplacementNamed(context, '/loginScreen');
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              const SizedBox(width: 70,),
              Lottie.asset(AssetPath.logoLottie,height: 200,width: 200),
            ],
          ),

          SizedBox(height: 30.h,),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("BIFDT Garments & Fashion Technology.",style: TextStyle(
                fontSize: 27.0,
                color: Colors.black, // First part black
                fontFamily: "FontMain2",
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
              ),),
              Text("The best fashion Institute in Bangladesh.",style: TextStyle(
                fontSize: 27.0,
                color: Colors.orange, // First part black
                fontFamily: "FontMain2",
                letterSpacing: 0.5,
                fontWeight: FontWeight.bold,
              ),),
            ],
          )





        ],
      )),

    );
  }
}
