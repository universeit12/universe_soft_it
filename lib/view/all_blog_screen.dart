
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:universe_soft_it/view/blog_details_screen.dart';
import 'package:universe_soft_it/view_model/blog_view_model.dart';
import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import '../resource/constant.dart';
import '../resource/common_widget/header1.dart';
import '../resource/common_widget/loading_widget.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../resource/constant_string.dart';
import '../resource/common_widget/youtube_player.dart';

import 'course_search_screen.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';
var a=3;
class AllBlog extends StatefulWidget {
  const AllBlog({super.key});

  @override
  State<AllBlog> createState() => _BlocState();
}

class _BlocState extends State<AllBlog> {
  // Create sample data

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BlogViewModel>();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
            onTap: () {
              CallNow.showDialog();
            },
            child: Lottie.asset(
              "assets/images/offer/whatsapp1.json",
              height: 90,
              width: 90,
            )),
        body: Container(
          color: Colors.white70,
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 25.h, vertical: 10.h),
                      child: Column(
                        children: [
                          const Row(
                            children: [
                              SizedBox(
                                width: 30,
                              ),
                              Header1(),
                            ],
                          ),
                          SizedBox(
                            height: 9.2.h,
                          ),
                          CourseSearch(
                            onchanged: (value) {
                              controller.filterCourses(value ?? '');
                            },
                            hintext: searchForCourse,
                          ),
                        ],
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.h, left: 8.h, right: 8.h, bottom: 2.h),
                  child: Container(
                      height: 50.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: kOrangeColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(25.r),
                            topRight: Radius.circular(25.r),
                          )),
                      child: Center(
                          child: Text(
                        allBlog,
                        style: TextStyle(
                            fontSize: 30.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "FontMain2",
                            letterSpacing: 0.5),
                      ))),
                ),
                SizedBox(
                  height: 5.h,
                ),
                Obx(() => SizedBox(
                  height: 420.h,
                  child: Visibility(
                    replacement: const Center(child: CustomLoadingWidget(),),
                    visible: !controller.inProgress,
                    child: GridView.builder(
                      itemCount: controller.showBlogList.length,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final blogs = controller.showBlogList[index];

                        return SizedBox(
                          height: 250.h,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            child: InkWell(
                              onTap: () {
                                // Here we will open details our page

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BlogDetails(blog: blogs),
                                    ));
                              },
                              child: Column(
                                children: [
                                  blogs.videoUrl == null ||
                                      blogs.videoUrl!.isEmpty
                                      ? Image.network(
                                    blogs.blogImageUrl.toString(),
                                    fit: BoxFit.fill,
                                    height: 80.h,
                                    width: double.infinity,
                                  )
                                      : NetworkVideoPlayer(
                                    videoUrl:
                                    blogs.videoUrl.toString(),
                                    autoplay: false,
                                    isIconButton: false,
                                    height: 70.h,
                                    width: double.infinity,
                                    fit: BoxFit.fill,

                                  ),
                                  Flexible(
                                    child: Center(
                                      child: Text(
                                        blogs.title.toString(),
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey.shade800,
                                            fontFamily: "FontMain2",
                                            letterSpacing: 0.5),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Html(
                                      data: blogs.description.toString(),
                                      style: {
                                        "*": Style(
                                            maxLines: 1,
                                            textOverflow:
                                            TextOverflow.ellipsis,
                                            color: Colors.grey.shade800,
                                            fontSize: FontSize(13.0.sp),
                                            fontFamily: "FontMain2",
                                            letterSpacing: 0.5,
                                            fontWeight: FontWeight.bold),
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlogDetails(
                                                        blog: blogs),
                                              ));
                                        },
                                        child: Container(
                                          height: 25.h,
                                          width: 75.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: kOrangeColor,
                                          ),
                                          child: Center(
                                              child: Text(
                                                readMore,
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10.sp),
                                              )),
                                        ),
                                      ),
                                      Container(
                                          height: 25.h,
                                          width: 55.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            color: kOrangeColor,
                                          ),
                                          child: Center(
                                              child: Text(
                                                blogs.date.toString(),
                                                style: TextStyle(
                                                    fontSize: 9.sp,
                                                    color: Colors.white),
                                              ))),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5.h,
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
                const Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: MapLocationSection(),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8, right: 8, top: 8),
                  child: FooterSection(),
                ),
                SizedBox(
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 2),
      ),
    );
  }


}
