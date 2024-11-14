import 'dart:convert';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:universe_soft_it/resource/common_widget/screen_background.dart';
import 'package:universe_soft_it/repository/admission_controller.dart';

import 'package:universe_soft_it/resource/common_widget/toast_message.dart';
import 'package:universe_soft_it/view_model/addmission_view_model.dart';

import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import '../resource/constant.dart';

import '../resource/common_widget/custom_text_button.dart';
import '../resource/common_widget/custom_text_filed.dart';
import '../resource/common_widget/header2.dart';
import '../resource/common_widget/call_now_widget.dart';

import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';
import '../models/popular_course_model.dart';
import '../resource/constant_string.dart';

class OnlineAdmission extends StatefulWidget {
  const OnlineAdmission({super.key});

  @override
  State<OnlineAdmission> createState() => _OnlineAdmissionState();
}

class _OnlineAdmissionState extends State<OnlineAdmission> {

  final _emailTEController = TextEditingController();
  final _nameTEController = TextEditingController();
  final _numberTEController = TextEditingController();
  final _addressTEController = TextEditingController();
  final _websiteTEController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final controller = Get.find<AddmissionViewModel>();

    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: (){
            CallNow.showDialog();
          },
          child: Lottie.asset("assets/images/offer/whatsapp1.json",height: 90,width: 90,)),
      body: ScreenBackground(
          child: ListView(
                  children: [
          Container(
              height: 150.h,
              decoration: BoxDecoration(
                  color: kOrangeColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.r),
                    //bottomRight: Radius.circular(25.r),
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.w),
                child: const Column(
                  children: [
                    Header2(),
                  ],
                ),
              )),
          Column(
            children: [
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.all(8.0.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      admissionForm,
                      style: TextStyle(
                          fontSize: 27.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: "FontMain2",
                          letterSpacing: 0.5),
                    ),
                    const Text(
                      unlockCreative,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: "FontMain3",
                          letterSpacing: 0.5),
                    ),
                    const Text(
                      fashionDreams,
                      style: TextStyle(
                          color: kPrimaryColor,
                          fontFamily: "FontMain3",
                          letterSpacing: 0.5),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameTEController,
                        hintext: name,
                        bordercolor: kPrimaryColor,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return pleaseEnterName;
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      CustomTextField(

                        controller: _emailTEController,
                        keyboardType: TextInputType.emailAddress,

                        hintext: email,
                        bordercolor: kPrimaryColor,
                        validator: controller.validateEmail,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        controller: _numberTEController,
                        keyboardType: TextInputType.number,

                        hintext: contactNo,
                        bordercolor: kPrimaryColor,
                        validator: controller.validateNumber,
                      ),
                      Obx(() {
                        return Padding(
                          padding: const EdgeInsets.only(
                            left: 25,
                            right: 25,
                          ),
                          child: Container(
                              margin: const EdgeInsets.only(top: 15.0),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 3.0),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.teal),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: DropdownButton<PopularCourseModel>(

                                underline: const SizedBox.shrink(),
                                isExpanded: true,
                                hint: const Text(
                                  'Select Course',
                                  style: TextStyle(
                                    color: Colors.grey, // Hint text color
                                    fontSize: 12.0,
                                  ),
                                ),
                  
                  
                                value: controller.selectedCourse.value,
                                onChanged: (PopularCourseModel? value) {
                                  controller.onCourseSelected(value);
                                  //controller.fetchDivisions();
                                },
                                items: controller.course.map((course) {
                                  return DropdownMenuItem<PopularCourseModel>(
                                    value: course,
                                    child: Text(
                                      course.title.toString(),
                                      style: const TextStyle(
                                          fontFamily: "FontMain4",
                                          fontSize: 14,
                                          color: Colors.black38),
                                    ),
                                  );
                                }).toList(),
                              )),
                        );
                      }),

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DropdownButtonFormField(
                              value: controller.selectedGenderVal,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return pleaseEnterGender;
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                hintText: gender,
                                hintStyle: TextStyle(
                                    fontFamily: "FontMain3", fontSize: 16),
                                border: InputBorder.none,
                              ),
                              items: controller.genderTypeList.map((d) {
                                return DropdownMenuItem(
                                  value: d,
                                  child: Text(
                                    d,
                                    style: const TextStyle(
                                        fontFamily: "FontMain4",
                                        fontSize: 14,
                                        color: Colors.black38),
                                  ),
                                );
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  selectedGenderVal = val!;
                                });
                              }),
                        ),
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomTextField(
                        controller: _addressTEController,

                        hintext: address,
                        bordercolor: kPrimaryColor,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return pleaseEnterAddress;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      CustomTextField(
                        controller: _websiteTEController,

                        hintext: howKnow,
                        bordercolor: kPrimaryColor,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return pleaseEnterAboutApp;
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Obx(() => CustomTextButton(
                        isLoading: controller.inProgress,
                          text: " submit",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              controller.postAddmissionRequest();
                            }
                          })),
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
              ),
            ],
          ),
                  ],
                )),
      bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 4),
    );
  }


}
