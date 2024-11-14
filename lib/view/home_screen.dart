import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:universe_soft_it/resource/constant.dart';

import 'package:universe_soft_it/view/blog_screen.dart';
import 'package:universe_soft_it/view/course_search_screen.dart';
import 'package:universe_soft_it/view/faculty_member_screen.dart';
import 'package:universe_soft_it/view/all_course_screen.dart';
import 'package:universe_soft_it/resource/common_widget/header.dart';
import 'package:universe_soft_it/view/popular_course_screen.dart';
import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';

import 'package:lottie/lottie.dart';

import '../resource/common_widget/offer.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';
import '../repository/notification_controller.dart';
import '../resource/common_widget/photo_galary_btton.dart';
import '../resource/constant_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final notificationController = Get.put(NotificationController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationController.fetchBlogs();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: () {
            CallNow.showDialog();
            //launchUrl(whatsapp);
          },
          child: Lottie.asset(
            "assets/images/offer/whatsapp1.json",
            height: 90,
            width: 90,
          )),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 170.h,
                  decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 10),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 10.h,
                        ),
                        const Header(),
                        SizedBox(
                          height: 13.h,
                        ),
                        CourseSearch(
                          hintext: searchForCourse,
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AllPopularCourse(),
                                ));
                          },
                        ),
                      ],
                    ),
                  )),
              // Now show offer
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                     Offer(),
                    const PopularCourse(),
                    SizedBox(
                      height: 30.h,
                    ),
                    const BlogScreen(),
                    SizedBox(
                      height: 20.h,
                    ),
                    const Faculty(),
                    SizedBox(
                      height: 30.h,
                    ),
                    Text(
                      "Student Photo Gallery",
                      style: TextStyle(
                          fontSize: 25.sp,
                          fontWeight: FontWeight.w800,
                          fontFamily: "FontMain2",
                          letterSpacing: 0.7,
                          color: Colors.black38),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    PhotoGalleryButtons(),
                    SizedBox(
                      height: 20.h,
                    ),
                    const MapLocationSection(),




                    const FooterSection(),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomAppBarNavigation(
        selectedItem: 0,
      ),
    );
  }
}




