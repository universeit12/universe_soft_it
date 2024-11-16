

import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:readmore/readmore.dart';
import 'package:universe_soft_it/resource/common_widget/loading_widget.dart';
import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import '../models/carrer_objective_model.dart';
import '../models/course_category_model.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../resource/common_widget/youtube_player.dart';
import '../view_model/course_details_view_model.dart';
import 'online_admission_screen.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';
import '../models/popular_course_model.dart';
import '../models/course_semister_model.dart';

class CourseDetailsScreen extends StatefulWidget {
  final PopularCourseModel course;

  const CourseDetailsScreen({super.key, required this.course});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> {
  String? videoId;


  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CourseDetailsViewModel(widget.course));
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: controller.shareCourseDetails,
            child: Container(
              height: 33.h,
              width: 90.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.blue),
              child: const Center(
                  child: Text(
                "Share Now",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
              )),
            ),
          ),
          SizedBox(
            width: 10.w,
          )
        ],
      ),
      floatingActionButton: GestureDetector(
          onTap: () {
            CallNow.showDialog();
          },
          child: Lottie.asset(
            "assets/images/offer/whatsapp1.json",
            height: 90,
            width: 90,
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildYoutubeVideoSection(),
            SizedBox(height: 20.h),
            _buildCourseTitleNotice(context,controller),
            _buildCourseDetails(controller),
            const SizedBox(
              height: 10,
            ),
            const Center(
                child: Text(
              "Career Objectives",
              style: TextStyle(
                  fontSize: 25,
                  fontFamily: "FontMain2",
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.75),
            )),
            const Padding(
              padding: EdgeInsets.only(left: 16, right: 16),
              child: Divider(),
            ),
            _buildCareerObjective(controller),
            SizedBox(
              height: 20.h,
            ),
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
      bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 1),
    );
  }

  Widget _buildYoutubeVideoSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10.r)),
            child: NetworkVideoPlayer(
              videoUrl: widget.course.videoUrl.toString(),
              autoplay: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseTitleNotice(BuildContext context,controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(top: 20.h, left: 20.h, right: 20.h),
        child: Column(
          children: [
            Center(
              child: Text(
                widget.course.title.toString(),
                style: TextStyle(
                  fontSize: 25.sp,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontFamily: "FontMain2",
                  letterSpacing: 0.5,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Column(
              children: [
                Text(
                  controller.extractedText2.value.toString(),
                  style: const TextStyle(
                    color: Colors.red,
                    fontFamily: "FontMain2",
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 15.h),
                Row(
                  children: [
                    Text(
                      'Admission Notice',
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "FontMain2",
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(width: 95.w),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  OnlineAdmission(),
                          ),
                        );
                      },
                      child: Container(
                        height: 35.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.all(Radius.circular(11.r)),
                        ),
                        child: Center(
                          child: Text(
                            'Enroll Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18.sp,
                              fontFamily: "FontMain2",
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Container(
                  height: 30.h,
                  color: Colors.red,
                  child: Marquee(
                    text: controller.extractedText.value.toString(),
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 50.0,
                    pauseAfterRound: const Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: const Duration(milliseconds: 500),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
                SizedBox(height: 30.h),
                Text(
                  'Course Details',
                  style: TextStyle(
                    fontSize: 26.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "FontMain2",
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCareerObjective(controller) {
    return Obx(() => Visibility(
      replacement: const Center(child: CustomLoadingWidget()),
      visible: !controller.inProgress,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: controller.carerObjectiveList.length,
        itemBuilder: (context, index) {
          final objective = controller.carerObjectiveList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var faq in objective.objectiveFAQ ?? [])
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      faq.question.toString(),
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "FontMain2",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.75,
                      ),
                    ),
                    ReadMoreText(
                      faq.answer.toString(),
                      trimMode: TrimMode.Line,
                      trimLines: 2,
                      colorClickableText: Colors.pink,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      moreStyle: const TextStyle(
                        fontSize: 14,
                        fontFamily: "FontMain2",
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.75,
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
            ],
          );
        },
      ),
    ));
  }


  Widget _buildCourseDetails(controller) {
    return Obx(() => SizedBox(
      height: 620.h,
      child: Padding(
        padding: EdgeInsets.all(10.0.r),
        child: Visibility(
          replacement: const Center(child: CustomLoadingWidget()),
          visible: !controller.inProgress,
          child: DefaultTabController(
            length: controller.courseCategory.length,
            child: Column(
              children: [
                TabBar(
                  // Map the course categories to Tab widgets
                  tabs: controller.courseCategory.map((category) {
                    return Tab(
                      child: Text(
                        "${category.duration} ${category.type}",
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          fontFamily: "FontMain2",
                          letterSpacing: .5,
                        ),
                      ),
                    );
                  }).toList(),  // Ensure this returns a List<Tab>
                ),
                SizedBox(
                  height: 10.h,
                ),
                Expanded(
                  child: TabBarView(
                    // Map the course categories to corresponding widget views
                    children: controller.courseCategory.map((category) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 400,
                              child: FutureBuilder<CourseSemesterModel>(
                                future: controller.fetchSemesterWithSpecificCourse(category.sId),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData && snapshot.data != null) {
                                    final semesterCategory = snapshot.data!;
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: controller.semesterCategory.length,
                                      itemBuilder: (context, index) {
                                        final semester = controller.semesterCategory[index];
                                        // Build the content for each semester
                                        return Column(
                                          children: [
                                            // Add widgets related to the semester here
                                          ],
                                        );
                                      },
                                    );
                                  } else if (snapshot.hasError) {
                                    return const Center(
                                      child: Text('Failed to load data'),
                                    );
                                  } else {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(), // Ensure this returns a List<Widget> for each tab's view
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }


  Widget _buildCustomContainer({title, details, color}) {
    return Container(
      decoration: BoxDecoration(
          color: color, border: Border.all(width: .5, color: Colors.white)),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: "FontMain2",
                fontWeight: FontWeight.w500,
                letterSpacing: 0.75),
          ),
          Flexible(
              child: Text(
            details,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontFamily: "FontMain2",
                fontWeight: FontWeight.w500,
                letterSpacing: 0.75),
          )),
        ],
      ),
    );
  }
}
