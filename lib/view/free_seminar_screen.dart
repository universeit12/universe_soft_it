
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/resource/constant.dart';

import 'package:universe_soft_it/resource/common_widget/screen_background.dart';

import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';

import '../resource/common_widget/custom_text_button.dart';
import '../resource/common_widget/custom_text_filed.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/header2.dart';
import '../resource/common_widget/map_location.dart';
import '../models/popular_course_model.dart';
import '../resource/constant_string.dart';
import '../view_model/free_seminar_view_model.dart';




class FreeSeminarScreen extends StatelessWidget {
  FreeSeminarScreen({super.key});




  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _numberController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FreeSeminarViewModel>();
    return Scaffold(

     resizeToAvoidBottomInset: false,
      body: ScreenBackground(child: Container(
        color: Colors.white10,
        child: ListView(
          children: [
            Container(
                height: 150.h,
                decoration:  BoxDecoration(
                    color: kOrangeColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r),
                    )
                ),
                child:  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.h,vertical: 10.h),
                  child:  const Column(
                    children: [
                      //SizedBox(height: 15.h,),
                      Header2(),

                    ],
                  ),
                )),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding:  EdgeInsets.all(8.0.r),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Text(
                    freeSeminarForm,
                    style: TextStyle(
                        fontSize: 29.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5),
                  ),
                  const Text(
                    fillupFreeSeminar,style: TextStyle(color: kPrimaryColor,fontFamily: "FontMain3",letterSpacing: 0.5),),

                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),

            Form(
              key: _formKey ,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    CustomTextField(controller: _nameController,
                
                      hintext: enterName1,
                      bordercolor: Colors.black,
                      validator: (value){
                        if(value!.isEmpty){
                          return pleaseEnterName;
                
                        }
                        return null;
                
                      },
                    ),
                    SizedBox(height: 15.h,),
                    CustomTextField(
                      controller: _emailController,
                      hintext: enterEmail,
                      bordercolor: Colors.black,
                      validator: controller.validateEmail,
                    ),
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
                                  child: Text(course.title.toString(),style: const TextStyle(fontFamily: "FontMain4",fontSize: 14,color: Colors.black38),),
                                );
                              }).toList(),
                            )),
                      );
                    }),
                    SizedBox(height: 15.h,),
                
                    CustomTextField(
                      controller:_numberController,
                      hintext: whatappNumber,
                      bordercolor: Colors.black,
                      validator: controller.validateNumber,
                    ),
                
                    Padding(
                      padding:  const EdgeInsets.only(left: 25,right: 25,),
                      child:Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 3.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.teal),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: DropdownButtonFormField(
                            value: controller.courseTypeList.contains(controller.selectedTypeVal)
                                ? controller.selectedTypeVal
                                : null, // Ensure selectedTypeVal is valid
                            isDense: true,
                            decoration: const InputDecoration(
                              hintText: selectSegmentType,
                              border: InputBorder.none,
                            ),
                            items: controller.courseTypeList.map((b) {
                              return DropdownMenuItem(
                                value: b,
                                child: Text(
                                  b,
                                  style: const TextStyle(fontFamily: "FontMain4", fontSize: 14, color: Colors.black38),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              controller.updateSelectedTypeVal(value!);
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return pleaseSelectSeg;
                              }
                              return null;
                            },
                          )
                      ),
                    ),
                    const SizedBox(height: 30,),
                
                
                    Obx(() => CustomTextButton(
                        text: submit, onTap: () async {
                
                      if(_formKey.currentState!.validate()) {

                        final result = await controller.postFreeSeminar(name: _nameController.text,email: _emailController.text,course: controller.selectedCourse,whatsapp: _numberController.text);
                        if(result){
                          Get.snackbar("Successful", "Free seminar request successfully submitted");
                        }
                        else{
                          Get.snackbar("Error", "Something went wrong");
                        }

                
                
                
                      }
                
                
                    },
                      isLoading: controller.inProgress,
                    )),
                    SizedBox(
                      height: 30.h,
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
      )),
      bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 3),

    );
  }


}
