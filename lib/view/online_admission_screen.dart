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
  final controller = Get.put(AdmissionController());
  _OnlineAdmissionState() {
    selectedVal = controller.courseList[0];
    selectedGenderVal = controller.genderTypeList[0];
  }

  String selectedVal = "";
  String selectedGenderVal = "";

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                        controller: controller.nameController.value,
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

                        controller: controller.emailController.value,
                        keyboardType: TextInputType.emailAddress,

                        hintext: email,
                        bordercolor: kPrimaryColor,
                        validator: controller.validateEmail,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      CustomTextField(
                        controller: controller.numberController.value,
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
                              value: selectedGenderVal,
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
                        controller: controller.addressController.value,

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
                        controller: controller.aboutWebsiteController.value,

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
                        isLoading: controller.isloading.value,
                          text: " submit",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              onlineAdmissionApi();
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

  void onlineAdmissionApi() async {
    try {
      controller.isloading.value =true;
      var url = "$baseUrl/admission";
      var data = {
        "name": controller.nameController.value.text,
        "email": controller.emailController.value.text,
        "course": controller.selectedCourse.toString(),
        "gender": selectedGenderVal.toString(),
        "contact": controller.numberController.value.text,
        "address": controller.addressController.value.text,
        "website": controller.aboutWebsiteController.value.text
      };
      var body = json.encode(data);
      var urlParse = Uri.parse(url);
      var response = await http.post(urlParse,
          body: body, headers: {"Content-Type": "application/json"});
      var data2 = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        controller.isloading.value =false;
        Get.snackbar("Successful", "Successfully Submitted");
      }
      debugPrint(data2.toString());
    } on SocketException {
      controller.isloading.value =false;
      ToastMessage.error("No Internet");
    } catch (e) {
      controller.isloading.value =false;
      ToastMessage.error("Something went wrong");
      debugPrint(e.toString());
    }
  }
}
