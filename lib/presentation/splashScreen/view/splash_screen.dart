

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universe_soft_it/Asset_path/image_path.dart';
import 'package:universe_soft_it/constant/constant_string.dart';

import '../../../routes/routes_name.dart';




class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer( const Duration(seconds: 2), () {

      Navigator.pushNamed(context, RouteName.loginScreen);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(


                children: [
                  SizedBox(
                    width: 120.w,
                    height: 120.h,
                    child: Card(
                      elevation: 200,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(200.r),
                        ),

                        child: Image.asset(AssetPath.bifdtLogo)),
                  ),

                   SizedBox(height: 40.h,),
                  Text(bifdt,style: TextStyle(fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                    color: Colors.black
                  ),),
                ],
              ),
              const SizedBox(width: 30,),
              Column(
                children: [
                  Text(learnSkill,style: TextStyle(fontWeight: FontWeight.w500,fontSize: 27.sp,color: Colors.green),),
                   SizedBox(height: 20.h,),
                  SizedBox(
                    height: 50.h,
                    width: 150.w,

                    child: ElevatedButton.icon(onPressed: (){}, icon:  Icon(Icons.leaderboard_rounded,color: Colors.red,size: 26.sp,), label: Text(topSkill,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold,color: Colors.red),),)
                  ),
                ],
              )
            ],
          ),
           SizedBox(height: 40.h,),
            Padding(
             padding: EdgeInsets.only(left: 80.h,right: 80.h),
             child: LinearProgressIndicator(color: Colors.red,minHeight: 6.h,),
           ),
            Padding(
             padding: EdgeInsets.only(top: 80.h),
             child: Text("Version 1.0.0",style: TextStyle(
               fontSize: 15.sp,
               fontWeight: FontWeight.w700,
               color: Colors.black
             ),),
           ),

        ],
      ),

    );
  }
}
