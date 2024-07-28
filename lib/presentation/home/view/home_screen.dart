


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universe_soft_it/component/bottom_app_bar.dart';
import 'package:universe_soft_it/constant/constant.dart';
import 'package:universe_soft_it/presentation/blog/view/blog.dart';

import 'package:universe_soft_it/widget/course_search.dart';
import 'package:universe_soft_it/presentation/faculty/view/faculty_member.dart';
import 'package:universe_soft_it/widget/header.dart';
import 'package:universe_soft_it/widget/notification.dart';
import 'package:universe_soft_it/widget/offer.dart';
import 'package:universe_soft_it/presentation/popular_course/view/popular_course.dart';





class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      endDrawer:  const Notification1(),
      body: SafeArea(
        child: SingleChildScrollView(

          child: Column(
            children: [
              Container(
                height: 170.h,
                  decoration:  BoxDecoration(
                    color: kOrangeColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r),
                    )
                  ),
                  child:   Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.h,vertical: 10.h),
                    child: Column(
                      children: [
                        SizedBox(height: 10.h,),
                        Header(),
                        SizedBox(height: 13.h,),
                        CourseSearch(),
                      ],
                    ),
                  )),
              // Now show offer
               Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Column(
                  children: [
                    SizedBox(height: 20.h,),
                    Offer(),
                    SizedBox(height: 30.h,),
                    PopularCourse(),

                    SizedBox(height: 30.h,),
                    BlogScreen(),
                    SizedBox(height: 20.h,),
                    Faculty(),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomApp(selectedItem: 1,),
    );
  }
}
