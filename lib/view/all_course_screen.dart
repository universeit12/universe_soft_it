import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:universe_soft_it/resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import 'package:universe_soft_it/view_model/popular_course_view_model.dart';
import '../resource/constant.dart';
import '../resource/common_widget/header1.dart';
import '../resource/common_widget/loading_widget.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';
import '../models/popular_course_model.dart';
import '../resource/constant_string.dart';
import 'course_details_screen.dart';
import 'course_search_screen.dart';

class AllPopularCourse extends StatelessWidget {
  const AllPopularCourse({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PopularCourseViewModel>();

    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
          onTap: () {
            CallNow.showDialog();
          },
          child: Lottie.asset("assets/images/offer/whatsapp1.json", height: 90, width: 90),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 170.h,
                decoration: BoxDecoration(
                  color: kOrangeColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.r),
                    bottomRight: Radius.circular(25.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      SizedBox(height: 5.h),
                      Row(
                        children: [
                          SizedBox(width: 25.w),
                          const Header1(),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      CourseSearch(
                        onchanged: (value) {
                          controller.filterCourses(value ?? '');
                        },
                        hintext: searchForCourse,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.h),
                child: Container(
                  height: 50.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: kOrangeColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      topRight: Radius.circular(25.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      allCourse,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: "FontMain2",
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Obx(() => SizedBox(
                height: 390.h,
                child: Visibility(
                    replacement: const Center(child: CustomLoadingWidget()),
                    visible: !controller.inProgress,
                    child: GridView.builder(
                        shrinkWrap: true,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.showingProduct.length,
                        itemBuilder: (context, index) {
                          PopularCourseModel data = controller.showingProduct[index];
                          return SizedBox(
                            width: 200.w,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailsScreen(course: data)));
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(data.bannerImages![0].toString(), height: 90.h, width: double.infinity, fit: BoxFit.cover),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: 3.h),
                                        Text(
                                          data.title ?? '',
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade800,
                                            fontFamily: "FontMain2",
                                            letterSpacing: 0.5,
                                          ),
                                        ),
                                        Html(
                                          data: data.description ?? '',
                                          style: {
                                            "*": Style(
                                              maxLines: 1,
                                              textOverflow: TextOverflow.ellipsis,
                                              color: Colors.grey.shade800,
                                              fontSize: FontSize(14.0.sp),
                                              fontFamily: "FontMain2",
                                              letterSpacing: 0.5,
                                            ),
                                          },
                                        ),
                                        SizedBox(height: 2.h),
                                        Row(
                                          children: [
                                            SizedBox(width: 10.h),
                                            Row(
                                              children: List.generate(
                                                4,
                                                    (index) => Icon(Icons.star, size: 14.sp, color: Colors.orange),
                                              )..add(Icon(Icons.star_half_sharp, size: 14.sp, color: Colors.orange)),
                                            ),
                                            SizedBox(width: 10.h),
                                            Container(
                                              height: 28.h,
                                              width: 80.w,
                                              decoration: BoxDecoration(
                                                color: kOrangeColor,
                                                borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => CourseDetailsScreen(course: data),
                                                    ),
                                                  );
                                                },
                                                child: Center(
                                                  child: Text(
                                                    "Details",
                                                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13.sp),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                  ),

              )),
              SizedBox(height: 10.h),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: MapLocationSection(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: FooterSection(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
        bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 1),
      ),
    );
  }
}
