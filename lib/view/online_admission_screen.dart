import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:universe_soft_it/resource/common_widget/screen_background.dart';
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

class OnlineAdmission extends StatelessWidget {
  OnlineAdmission({super.key});

  final _emailTEController = TextEditingController();
  final _nameTEController = TextEditingController();
  final _numberTEController = TextEditingController();
  final _addressTEController = TextEditingController();
  final _whatsappTEController = TextEditingController();
  final _websiteTEController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddmissionViewModel>();

    return Scaffold(
      floatingActionButton: GestureDetector(
          onTap: () {
            CallNow.showDialog();
          },
          child: Lottie.asset("assets/images/offer/whatsapp1.json", height: 90, width: 90)),
      body: ScreenBackground(
          child: ListView(
            children: [
              Container(
                  height: 150.h,
                  decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r),
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
                  SizedBox(height: 10.h),
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
                          style: TextStyle(color: kPrimaryColor, fontFamily: "FontMain3", letterSpacing: 0.5),
                        ),
                        const Text(
                          fashionDreams,
                          style: TextStyle(color: kPrimaryColor, fontFamily: "FontMain3", letterSpacing: 0.5),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15.h),
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
                          SizedBox(height: 10.h),
                          CustomTextField(
                            controller: _whatsappTEController,
                            keyboardType: TextInputType.number,
                            hintext: contactNo,
                            bordercolor: kPrimaryColor,
                            validator: controller.validateNumber,
                          ),
                          //SizedBox(height: 15.h,),
                          Obx(() {
                            return Padding(
                              padding:  const EdgeInsets.only(left: 25,right: 25,),
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
                                    hint: Text('Select Course',style: TextStyle(
                                      color: Colors.grey, // Hint text color
                                      fontSize: 12.0.sp,
                                    ),),
                                    value: controller.selectedCourse.value,
                                    onChanged: (PopularCourseModel? value) {
                                      controller.onCourseSelected(value);
                                      //controller.fetchDivisions();
                                    },
                                    items: controller.course.map((course) {
                                      return DropdownMenuItem<PopularCourseModel>(
                                        value: course,
                                        child: Text(course.title.toString(),style: const TextStyle(fontFamily: "FontMain4",fontSize: 14,color: Colors.black),),
                                      );
                                    }).toList(),
                                  )),
                            );
                          }),




                          Padding(
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child:  Container(
                                margin: const EdgeInsets.only(top: 15.0),
                                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.teal),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: DropdownButtonFormField<String>(
                                  value: controller.genderTypeList.contains(controller.selectedGenderVal)
                                      ? controller.selectedGenderVal
                                      : null,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return pleaseEnterGender;
                                    }
                                    return null;
                                  },
                                  decoration: const InputDecoration(
                                    hintText: gender,
                                    hintStyle: TextStyle(fontSize: 14,color: Colors.grey),
                                    border: InputBorder.none,
                                  ),
                                  items: controller.genderTypeList.toSet().map((d) {
                                    return DropdownMenuItem(
                                      value: d,
                                      child: Text(d,
                                          style: const TextStyle(
                                              fontFamily: "FontMain4",
                                              fontSize: 14,
                                              color: Colors.black)),
                                    );
                                  }).toList(),
                                  onChanged: (val) {
                                    controller.selectedGenderVal = val!;
                                  },
                                ),
                              ),

                          ),

                          SizedBox(height: 15.h),
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
                          SizedBox(height: 15.h),
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
                          SizedBox(height: 20.h),
                          Obx(() => CustomTextButton(
                            isLoading: controller.inProgress,
                            text: "Submit",
                            onTap: () async {
                              if (formKey.currentState!.validate()) {
                               final result = await controller.postAddmissionRequest(name: _nameTEController.text,
                                    email: _emailTEController.text,

                                    course: controller.selectedCourse.value?.title,
                                  address: _addressTEController.text,
                                  contact: _whatsappTEController.text,
                                  gender: controller.selectedGenderVal,
                                  website: _websiteTEController.text
                                );
                               if(result){
                                 Get.showSnackbar(const GetSnackBar(title: "Success",message: "Online Addmission Form Successfully Submitted",duration: Duration(seconds: 4),));

                                   _nameTEController.clear();
                                   _emailTEController.clear();
                                   _addressTEController.clear();
                                   _whatsappTEController.clear();
                                   _websiteTEController.clear();
                                   controller.resetSelectedCourse();
                                   controller.resetSelectedGender();



                               }
                              }
                            },
                          )),
                          SizedBox(height: 20.h),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: MapLocationSection(),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            child: FooterSection(),
                          ),
                          SizedBox(height: 20.h),
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
