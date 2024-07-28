import 'dart:convert';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:universe_soft_it/component/bottom_app_bar.dart';
import 'package:universe_soft_it/presentation/addmission/controller/admission_controller.dart';
import 'package:universe_soft_it/widget/custom_text_button.dart';
import 'package:universe_soft_it/widget/custom_text_filed.dart';

import '../../../constant/constant.dart';
import '../../../widget/header.dart';
import '../../../widget/header2.dart';

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
    return Scaffold(
      body: ListView(
        children: [
          Container(
              height: 150.h,
              decoration:  BoxDecoration(
                  color: kOrangeColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.r),
                    bottomRight: Radius.circular(25.r),
                  )),
              child:  Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.w),
                child: Column(
                  children: [
                    SizedBox(
                      height: 15.h,
                    ),
                    const Header2(),
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
                    Card(
                      elevation: 5,
                      child: Image.asset(
                        "assets/images/offer/Bifdt.png",
                        height: 60.h,
                        width: 60.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                     Text(
                      "Online Admission Form",
                      style: TextStyle(
                          fontSize: 27.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                        "Unlock Your Creative Potential and Transform Your",style: TextStyle(color: kPrimaryColor),),
                    const Text("FashionDreams into Reality—Enroll Today!",style: TextStyle(color: kPrimaryColor),),
                  ],
                ),
              ),
               SizedBox(
                height: 15.h,
              ),
              Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    CustomTextField(
                        controller: controller.nameController,
                        hintext: "Name",
                        bordercolor: kPrimaryColor,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Please enter a user name";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),
                    CustomTextField(
                        controller: controller.emailController,
                        hintext: "Email",
                        bordercolor: kPrimaryColor,
                      validator: controller.validateEmail,
                    ),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(20.h, 10.h, 20.h, 0.h),
                      child: DropdownButtonFormField(
                          value: selectedVal,
                          icon: const Icon(Icons.arrow_drop_down_circle),
                          dropdownColor: Colors.deepPurple.shade50,
                          decoration: const InputDecoration(
                            labelText: "Select Course",
                          ),
                          items: controller.courseList.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedVal = val!;
                            });
                          }),
                    ),
                    SizedBox(height: 20.h,),
                    CustomTextField(controller: controller.numberController, hintext: "Contact No", bordercolor: kPrimaryColor,validator: controller.validateNumber,),
                    Padding(
                      padding:  EdgeInsets.fromLTRB(20.h, 10.h, 20.h, 0.h),
                      child: DropdownButtonFormField(
                          value: selectedGenderVal,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter your gender";
                            }
                            return null;
                          },
                          icon: const Icon(Icons.arrow_drop_down_circle),
                          dropdownColor: Colors.deepPurple.shade50,
                          decoration: const InputDecoration(
                            labelText: "Gender",
                          ),
                          items: controller.genderTypeList.map((d) {
                            return DropdownMenuItem(
                              value: d,
                              child: Text(d),
                            );
                          }).toList(),
                          onChanged: (val) {
                            setState(() {
                              selectedGenderVal = val!;
                            });
                          }),
                    ),
                    SizedBox(height: 20.h,),
                    CustomTextField(controller: controller.addressController, hintext: "Address", bordercolor: kPrimaryColor,validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },),
                    SizedBox(height: 20.h,),
                    CustomTextField(controller: controller.aboutWebsiteController, hintext: "How do you know about app?", bordercolor: kPrimaryColor,validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter about our app";
                      }
                      return null;
                    },),

                    const SizedBox(height: 20,),
                    CustomTextButton(text: "Submit", onTap: (){
                      if (controller.formKey.currentState!.validate()) {
                        onlineAdmissionApi();
                        Fluttertoast.showToast(
                            msg: "Submit Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    }),
                    const SizedBox(height: 10,),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomApp(selectedItem: 4),
    );
  }

  void onlineAdmissionApi() async {
    var url = "https://bifdt-server-ashikur.vercel.app/admission";
    var data = {
      "name": controller.nameController.text,
      "email": controller.emailController.text,
      "course": selectedVal.toString(),
      "gender": selectedGenderVal.toString(),
      "contact": controller.numberController.text,
      "address": controller.addressController.text,
      "website": controller.aboutWebsiteController.text
    };
    var body = json.encode(data);
    var urlParse = Uri.parse(url);
    var response = await http.post(urlParse,
        body: body, headers: {"Content-Type": "application/json"});
    var data2 = jsonDecode(response.body);
    print(data2);
  }
}
