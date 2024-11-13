import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:html/dom.dart' as dom;
import "package:html/parser.dart" as html_parser;
import 'package:readmore/readmore.dart';
import 'package:share_plus/share_plus.dart';

import 'package:universe_soft_it/repository/course_details_controller.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';

import '../models/carrer_objective_model.dart';
import '../models/course_category_model.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../resource/constant_string.dart';
import '../resource/common_widget/youtube_player.dart';
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
  List<CarrerObjectiveModel> popularCourseList = [];
  List<CourseCategoryModel> courseCategory = [];
  List<CourseSemesterModel> semesterCategory = [];

  @override
  void initState() {
    super.initState();

    extractTextFromHtml(widget.course.admissionNotice.toString());
    extractTextFromHtml2(widget.course.bangla.toString());
    videoId = YoutubePlayer.convertUrlToId(widget.course.videoUrl.toString());
  }

  String extractedText = '';
  String extractedText2 = '';

  void extractTextFromHtml(String htmlString) {
    dom.Document document = html_parser.parse(htmlString);
    String text = document.body!.text;
    setState(() {
      extractedText = text;
    });
  }

  void extractTextFromHtml2(String htmlString) {
    dom.Document document = html_parser.parse(htmlString);
    String text = document.body!.text;
    setState(() {
      extractedText2 = text;
    });
  }
  void _shareCourseDetails() {
    final shareText = """
Course Title: ${widget.course.title}

Description: ${widget.course.description?.replaceAll(RegExp(r'<[^>]*>'), '')}

Watch the course video on YouTube: ${widget.course.videoUrl.toString()}

Click the link to watch the video and learn more about the course.
For More Details Visit Our Website: https://bifdt.info/
  """;

    Share.share(shareText);
  }


  Future<List<CourseCategoryModel>> fetchCourseCategory(courseId) async {
    courseCategory.clear();
    final response =
        await http.get(Uri.parse('$baseUrl/courseCategory/course/$courseId'));
    debugPrint(response.statusCode.toString());
    var data = jsonDecode(response.body.toString());
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        courseCategory.add(CourseCategoryModel.fromJson(index));
      }
      return courseCategory;
    } else {
      return courseCategory;
    }
  }

  Future<List<CarrerObjectiveModel>> fetchCarrerObjective(courseId) async {
    popularCourseList.clear();
    debugPrint("courseId");

    debugPrint(courseId);
    final response =
        await http.get(Uri.parse('$baseUrl/objectives/course/$courseId'));
    debugPrint(response.statusCode.toString());
    var data = jsonDecode(response.body.toString());
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        popularCourseList.add(CarrerObjectiveModel.fromJson(index));
      }
      return popularCourseList;
    } else {
      return popularCourseList;
    }
  }

  Future<List<CourseSemesterModel>> fetchSemesterWithSpecificCourse(
      catagoryId) async {
    semesterCategory.clear();
    debugPrint("CatagoryId");

    debugPrint(catagoryId);
    final response = await http
        .get(Uri.parse('$baseUrl/semesterByCourse/course/$catagoryId'));
    debugPrint(response.statusCode.toString());
    var data = jsonDecode(response.body.toString());
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data) {
        semesterCategory.add(CourseSemesterModel.fromJson(index));
      }
      return semesterCategory;
    } else {
      return semesterCategory;
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(CourseDetailsController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: _shareCourseDetails,
            child: Container(
              height: 33.h,
              width: 90.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.blue
              ),
              child: const Center(child: Text("Share Now",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
            ),
          ),
          SizedBox(width: 10.w,)

        ],
      ),
      floatingActionButton: GestureDetector(
          onTap: (){
            CallNow.showDialog();
          },
          child: Lottie.asset("assets/images/offer/whatsapp1.json",height: 90,width: 90,)),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            _buildYoutubeVideoSection(),

            SizedBox(height: 20.h),
            _buildCourseTitleNotice(context),
            _buildCourseDetails(),
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
            _buildCareerObjective(),
            SizedBox(
              height: 20.h,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 8,right: 8,top: 8),
              child: MapLocationSection(),
            ),




            const Padding(
              padding: EdgeInsets.only(left: 8,right: 8,top: 8),
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
                    child: NetworkVideoPlayer(videoUrl: widget.course.videoUrl.toString(),autoplay: true,),
                  ),
                ],
              ),
            );
  }

  Widget _buildCourseTitleNotice(BuildContext context) {
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
                          extractedText2,
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
                                    builder: (context) =>
                                        const OnlineAdmission(),
                                  ),
                                );
                              },
                              child: Container(
                                height: 35.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(11.r)),
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
                            text: extractedText,
                            style: TextStyle(color: Colors.white, fontSize: 16.sp),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            blankSpace: 20.0,
                            velocity: 50.0,
                            pauseAfterRound: const Duration(seconds: 1),
                            startPadding: 10.0,
                            accelerationDuration:
                                const Duration(milliseconds: 500),
                            accelerationCurve: Curves.linear,
                            decelerationDuration:
                                const Duration(milliseconds: 500),
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

  FutureBuilder<List<CarrerObjectiveModel>> _buildCareerObjective() {
    return FutureBuilder<List<CarrerObjectiveModel>>(
              future: fetchCarrerObjective(widget.course.sId),
              builder: (context, snapshot) {
                debugPrint(snapshot.data.toString());
                if (snapshot.hasData && popularCourseList.isNotEmpty) {
                  // Use a Column instead of ListView.builder when nested inside another scrollable
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: popularCourseList.length,
                      itemBuilder: (context, index) {
                        final objective = popularCourseList[index];
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: objective.objectiveFAQ!.length,
                          itemBuilder: (context, index2) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  objective.objectiveFAQ![index2].question
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 16,
                                      fontFamily: "FontMain2",
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.75),
                                ),
                                ReadMoreText(
                                  objective.objectiveFAQ![index2].answer
                                      .toString(),
                                  trimMode: TrimMode.Line,
                                  trimLines: 2,
                                  colorClickableText: Colors.pink,
                                  trimCollapsedText: 'Show more',
                                  trimExpandedText: 'Show less',
                                  moreStyle: const TextStyle(
                                      fontSize: 14,
                                      fontFamily: "FontMain2",
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.75),
                                ),
                                const SizedBox(height: 10),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  );
                } else {
                  // Data is empty
                  return const Center(
                    child: Text('No career objectives found'),
                  );
                }
              },
            );
  }

 Widget _buildCourseDetails() {
    return SizedBox(
              height: 620.h,
              child: Padding(
                padding: EdgeInsets.all(10.0.r),
                child: FutureBuilder<List<CourseCategoryModel>>(
                    future: fetchCourseCategory(widget.course.sId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return DefaultTabController(
                          length: courseCategory.length,
                          child: Column(
                            children: [
                              TabBar(
                                tabs: courseCategory.map((category) {
                                  return Tab(
                                    child: Text(
                                      "${category.duration} ${category.type}", // Display category information
                                      style: TextStyle(
                                          fontSize: 15.sp,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "FontMain2",
                                          letterSpacing: .5),
                                    ),
                                  );
                                }).toList(),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Expanded(
                                child: TabBarView(
                                  children: courseCategory.map((category) {
                                    return SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          SizedBox(
                                            height: 8.h,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft:
                                                      Radius.circular(10),
                                                  topRight:
                                                      Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.white)),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "     Course Title           :       ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  category.name.toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.green
                                                    .withOpacity(0.7),
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.white)),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "      Course Duration  :       ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  category.durationDetails
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.black26,
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.white)),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "     Regular Batch      :       ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  category.regularBatch
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.pink
                                                    .withOpacity(0.7),
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.white)),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "     Executive Batch   :       ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  category.executiveBatch
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.purple
                                                    .withOpacity(0.7),
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.white)),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "     Total Classes        :       ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  category.totalClass
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.green
                                                    .withOpacity(0.7),
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.white)),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "     Qualification         :       ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  category.qualification
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                )),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10),
                                                ),
                                                border: Border.all(
                                                    width: .5,
                                                    color: Colors.white)),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  "      Course Fee           :       ",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                ),
                                                Flexible(
                                                    child: Text(
                                                  category.courseFee
                                                      .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                      fontFamily: "FontMain2",
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0.75),
                                                )),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 30.h,
                                          ),
                                          SizedBox(
                                            height: 400,
                                            child: FutureBuilder<
                                                List<CourseSemesterModel>>(
                                              future:
                                                  fetchSemesterWithSpecificCourse(
                                                      category.sId),
                                              builder: (context, snapshot) {
                                                if (snapshot.hasData &&
                                                    snapshot.data != null) {
                                                  final semesterCategory =
                                                      snapshot.data!;

                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        semesterCategory
                                                            .length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      final semester =
                                                          semesterCategory[
                                                              index];

                                                      if (category.sId ==
                                                          semester.courseId) {
                                                        // Calculate total credits for the semester as a double
                                                        int totalCredits =
                                                            semester.subjects !=
                                                                    null
                                                                ? semester
                                                                    .subjects!
                                                                    .fold(
                                                                    0,
                                                                    (int sum,
                                                                        subject) {
                                                                      // Convert the subject's credit from String to double
                                                                      int creditValue =
                                                                          0;
                                                                      if (subject.credit !=
                                                                          null) {
                                                                        try {
                                                                          creditValue =
                                                                              int.parse(subject.credit!); // Parse String to double
                                                                        } catch (e) {
                                                                          creditValue =
                                                                              0; // Default to 0.0 if parsing fails
                                                                        }
                                                                      }
                                                                      return sum +
                                                                          creditValue; // Add to the total
                                                                    },
                                                                  )
                                                                : 0;

                                                        return Column(
                                                          children: [
                                                            Container(
                                                              width: double
                                                                  .infinity,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .red,
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10),
                                                                  topRight:
                                                                      Radius.circular(
                                                                          10),
                                                                ),
                                                                border: Border.all(
                                                                    width:
                                                                        .5,
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                  "All Semester",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white,
                                                                      fontSize:
                                                                          25,
                                                                      fontFamily:
                                                                          "FontMain2",
                                                                      fontWeight: FontWeight
                                                                          .w500,
                                                                      letterSpacing:
                                                                          0.75),
                                                                ),
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      30,
                                                                  width:
                                                                      260,
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .red,
                                                                    border: Border.all(
                                                                        width:
                                                                            .5,
                                                                        color:
                                                                            Colors.white),
                                                                  ),
                                                                  child:
                                                                      Center(
                                                                    child:
                                                                        Text(
                                                                      semester.semesterTitle ??
                                                                          'No Title',
                                                                      style: const TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 20,
                                                                          fontFamily: "FontMain2",
                                                                          fontWeight: FontWeight.w500,
                                                                          letterSpacing: 0.75),
                                                                    ),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Container(
                                                                  height:
                                                                      30,
                                                                  width:
                                                                      110,
                                                                  color: Colors
                                                                      .red,
                                                                  child: const Center(
                                                                      child: Text(
                                                                    "Credits",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            20,
                                                                        fontFamily:
                                                                            "FontMain2",
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                        letterSpacing: 0.75),
                                                                  )),
                                                                ),
                                                              ],
                                                            ),
                                                            // Ensure subjects are displayed if not null
                                                            if (semester
                                                                    .subjects !=
                                                                null)
                                                              ...semester
                                                                  .subjects!
                                                                  .map(
                                                                      (subject) {
                                                                return Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        Container(
                                                                          height: 30,
                                                                          width: 260,
                                                                          color: Colors.greenAccent,
                                                                          child: Center(
                                                                            child: Text(
                                                                              subject.name ?? 'No Subject Name',
                                                                              style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: "FontMain2", fontWeight: FontWeight.w500, letterSpacing: 0.75),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        const SizedBox(width: 2),
                                                                        Container(
                                                                          height: 30,
                                                                          width: 110,
                                                                          color: Colors.greenAccent,
                                                                          child: Row(
                                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Text(
                                                                                subject.credit ?? '0',
                                                                                style: const TextStyle(color: Colors.black, fontSize: 20, fontFamily: "FontMain2", fontWeight: FontWeight.w500, letterSpacing: 0.75),
                                                                              ),
                                                                              const Text("  Credit", style: TextStyle(color: Colors.black, fontSize: 20, fontFamily: "FontMain2", fontWeight: FontWeight.w500, letterSpacing: 0.75)),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            2),
                                                                  ],
                                                                );
                                                              }),

                                                            // Total credits row
                                                            Row(
                                                              children: [
                                                                Container(
                                                                  height:
                                                                      30,
                                                                  width:
                                                                      260,
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors.red,
                                                                      borderRadius: BorderRadius.only(
                                                                        bottomLeft:
                                                                            Radius.circular(10),
                                                                      )),
                                                                  child:
                                                                      const Center(
                                                                    child:
                                                                        Text(
                                                                      "Total",
                                                                      style: TextStyle(
                                                                          color: Colors.white,
                                                                          fontSize: 25,
                                                                          fontFamily: "FontMain2",
                                                                          fontWeight: FontWeight.w500,
                                                                          letterSpacing: 0.75),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  height:
                                                                      30,
                                                                  width:
                                                                      112,
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors.red,
                                                                      borderRadius: BorderRadius.only(
                                                                        bottomRight:
                                                                            Radius.circular(10),
                                                                      )),
                                                                  child:
                                                                      Row(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        "$totalCredits",
                                                                        style: const TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 20,
                                                                            fontFamily: "FontMain2",
                                                                            fontWeight: FontWeight.w500,
                                                                            letterSpacing: 0.75),
                                                                      ),
                                                                      const Text(
                                                                        " Credits",
                                                                        style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 20,
                                                                            fontFamily: "FontMain2",
                                                                            fontWeight: FontWeight.w500,
                                                                            letterSpacing: 0.75),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),

                                                           SizedBox(
                                                              height: 30.h,
                                                            ),
                                                          ],
                                                        );
                                                      } else {
                                                        return const SizedBox();
                                                      }
                                                    },
                                                  );
                                                } else if (snapshot
                                                    .hasError) {
                                                  return const Center(
                                                    child: Text(
                                                        'Failed to load data'),
                                                  );
                                                } else {
                                                  return const Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                }
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Data is empty
                        return const Center(
                          child: Text('No career objectives found'),
                        );
                      }
                    }),
              ),
            );
  }
}
