import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/resource/constant.dart';

import 'package:universe_soft_it/resource/common_widget/screen_background.dart';
import 'package:universe_soft_it/repository/free_seminar_controller.dart';
import 'package:http/http.dart' as http;
import 'package:universe_soft_it/resource/common_widget/toast_message.dart';
import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';

import '../resource/common_widget/custom_text_button.dart';
import '../resource/common_widget/custom_text_filed.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/header2.dart';
import '../resource/common_widget/map_location.dart';
import '../models/popular_course_model.dart';
import '../resource/constant_string.dart';




class FreeSeminarScreen extends StatefulWidget {
  const FreeSeminarScreen({super.key});

  @override
  State<FreeSeminarScreen> createState() => _FreeSeminarScreenState();
}


class _FreeSeminarScreenState extends State<FreeSeminarScreen> {

  final controller = Get.put(FreeSeminarController());
  _FreeSeminarScreenState(){
    selectedVal = controller.courseList[0] ;
   selectedTypeVal = controller.courseTypeList[0] ;

  }
  String selectedVal = "";
  String selectedTypeVal = "";



  @override
  Widget build(BuildContext context) {
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
              key: controller.formKey ,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h,),
                    CustomTextField(controller: controller.nameController,
                
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
                      controller: controller.emailController,
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
                      controller:controller.numberController,
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
                            value: selectedTypeVal,
                            isDense: true,
                
                            decoration: const InputDecoration(
                
                              hintText: selectSegmentType,
                              border: InputBorder.none,
                            ),
                
                            items: controller.courseTypeList.map(
                                    (b){
                                  return DropdownMenuItem(value: b,child: Text(b,style: const TextStyle(fontFamily: "FontMain4",fontSize: 14,color: Colors.black38),),);
                                }
                            ).toList(),
                            onChanged: (value){
                              setState(() {
                                selectedTypeVal = value!;
                              });
                
                            },
                            validator: (value){
                              if(value!.isEmpty){
                                return pleaseSelectSeg;
                
                              }
                              return null;
                
                            },
                          )),
                    ),
                    const SizedBox(height: 30,),
                
                
                    Obx(() => CustomTextButton(
                        text: submit, onTap: (){
                
                      if(controller.formKey.currentState!.validate()) {
                        freeSeminarRegister();
                
                
                
                      }
                
                
                    },
                      isLoading: controller.isLoading.value,
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
      bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 2),

    );
  }

  void freeSeminarRegister()async{

      try{
        controller.isLoading.value = true;
        var url = "$baseUrl/seminarRequest";
        var data = {
          "name":controller.nameController.text,
          "email": controller.emailController.text,
          "course": controller.selectedCourse.toString(),
          "whatsapp": controller.numberController.text,
          "segment" :selectedTypeVal.toString()

        };

        var body = json.encode(data);
        var urlParse = Uri.parse(url);
        var response = await http.post(
            urlParse,
            body: body,
            headers: {
              "Content-Type":"application/json"
            }
        );
        var data2 = jsonDecode(response.body);
        debugPrint(data2.toString());

        if(response.statusCode == 200 || response.statusCode == 201){
          controller.isLoading.value = false;

          ToastMessage.success(submitSuccess);



        }
      }catch (e){
        controller.isLoading.value = false;
        Get.snackbar("Error", "Some thing went wrong");
      }





  }
}
