import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import 'package:http/http.dart' as http;
import 'package:universe_soft_it/view_model/blog_view_model.dart';
import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import '../resource/constant.dart';
import '../resource/common_widget/custom_text_button.dart';
import '../resource/common_widget/custom_text_filed.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../resource/constant_string.dart';
import '../utils/utils.dart';
import '../resource/common_widget/youtube_player.dart';
import '../models/blog_model.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';
import 'package:path_provider/path_provider.dart';

class BlogDetails extends StatelessWidget {
  final BlogModel blog;

  // We create a controller for blog details
  final  controller = Get.find<BlogViewModel>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _nameTEController = TextEditingController();
  final _contactTEController = TextEditingController();
  final _commentTEController = TextEditingController();
  final nameFocusNode = FocusNode();
  final numberFocusNode = FocusNode();
  final commentFocusNode = FocusNode();

  BlogDetails({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: _shareContent,
            child: Container(
              height: 33.h,
              width: 90.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: Colors.blue,
              ),
              child: const Center(
                child: Text("Share Now",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600)),
              ),
            ),
          ),
          SizedBox(width: 10.w),
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
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.h),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Safely check if videoUrl is null or empty
                  blog.videoUrl == null || blog.videoUrl!.isEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          child: Image.network(
                            blog.blogImageUrl ??
                                'https://via.placeholder.com/150',
                            height: 230,
                            fit: BoxFit.fill,
                            width: double
                                .infinity, // Fallback to placeholder if null
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10.r)),
                          child: NetworkVideoPlayer(
                            videoUrl: blog.videoUrl.toString(),
                            autoplay: false,
                            isIconButton: false,
                          ),

                        ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 30.h,
                          width: 80.w,
                          decoration: BoxDecoration(
                            color: kOrangeColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                          ),
                          child: Center(
                            child: Text(
                              blog.date?.toString() ??
                                  'No Date', // Handle null date
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        SizedBox(width: 11.w),
                        Flexible(
                          child: Text(
                            blog.title ?? 'No Title', // Handle null title
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 19.sp,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontFamily: "FontMain2",
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 40.h),
                    Text(
                      blogDetails,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "FontMain2",
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Html(data: blog.description ?? 'No Description', style: {
                      // Style for the whole body
                      "body": Style(
                        fontSize: FontSize(18.0), // Set the default font size
                        fontFamily: "FontMain2", // Set custom font
                        color: Colors.black87, // Set default text color
                        lineHeight: const LineHeight(1.5), // Set line height
                      ),
                    }), // Handle null description
                    SizedBox(height: 30.h),
                    Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              SizedBox(width: 25.w),
                              Text(
                                leaveComment,
                                style: TextStyle(
                                  fontSize: 21.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "FontMain2",
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Column(
                            children: [
                              SizedBox(
                                height: 45,
                                child: CustomTextField(
                                  controller: _nameTEController,
                                  focusNode:nameFocusNode,
                                  hintext: yourName,
                                  bordercolor: Colors.black,
                                  onFieldSubmitted: (value) {
                                    Utils.fieldFocusChange(
                                        context,
                                        nameFocusNode,
                                        numberFocusNode);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      Utils.snackBarMessage(
                                          title: "Empty",
                                          message: "Please enter name");
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                height: 45,
                                child: CustomTextField(
                                  controller:_contactTEController,
                                  focusNode: numberFocusNode,
                                  hintext: yourContactNumber,
                                  bordercolor: Colors.black,
                                  keyboardType: TextInputType.phone,
                                  onFieldSubmitted: (value) {
                                    Utils.fieldFocusChange(
                                        context,
                                        numberFocusNode,
                                        commentFocusNode);
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      Utils.snackBarMessage(
                                          title: "Empty",
                                          message: "Please enter number");
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                height: 45,
                                child: CustomTextField(
                                  controller:
                                      _commentTEController,
                                  focusNode: commentFocusNode,
                                  hintext: leaveComment,
                                  bordercolor: Colors.black,
                                  keyboardType: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      Utils.snackBarMessage(
                                          title: "Empty",
                                          message: "Please enter a comment");
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Obx(
                                () => CustomTextButton(
                                  text: submit,
                                  onTap: () async {
                                    if (_nameTEController.text.isNotEmpty) {
                                      if (_contactTEController.text.isNotEmpty) {
                                        if (_contactTEController.text.length == 11) {
                                          if (_commentTEController.text.isNotEmpty) {
                                            final result = await controller.postBlogComment(name: _nameTEController.text,contact: _contactTEController.text,comment: _commentTEController.text);

                                            if(result){
                                              Get.showSnackbar(const GetSnackBar(title: "Success",message: "Successfully Comment Submitted",duration: Duration(seconds: 3),));
                                            }
                                            else{
                                              Get.showSnackbar(const GetSnackBar(title: "Error",message: "Some thing went wrong!",duration: Duration(seconds: 3),));

                                            }
                                          } else {
                                            Get.snackbar("Error",
                                                "Please enter a comment");
                                          }
                                        } else {
                                          Get.snackbar("Error",
                                              "Please enter 10 digits of number");
                                        }
                                      } else {
                                        Get.snackbar(
                                            "Error", "Please enter a number");
                                      }
                                    } else {
                                      Get.snackbar(
                                          "Error", "Please enter name");
                                    }
                                  },
                                  height: 40.h,
                                  width: 200.w,
                                  fontSize: 18.sp,
                                  isLoading: controller.inProgress,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),
                          const MapLocationSection(),
                          const FooterSection(),

                          // Additional form fields and content here...
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 0),
    );
  }

  // Function to download and share the image and text
  Future<void> _shareContent() async {
    final descriptionWithoutHtml =
        blog.description?.replaceAll(RegExp(r'<[^>]*>'), '') ?? '';

    final shareText = """
Blog Title: ${blog.title}

Date: ${blog.date}

Description: $descriptionWithoutHtml

For More Details Visit Our Website: https://bifdt.info/
""";

    try {
      final http.Response response =
          await http.get(Uri.parse(blog.blogImageUrl ?? ''));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/blog_image.png');
        await file.writeAsBytes(bytes);
        await Share.shareXFiles([XFile(file.path)], text: shareText);
      }
    } catch (e) {
      debugPrint('Error sharing content: $e');
    }
  }
}
