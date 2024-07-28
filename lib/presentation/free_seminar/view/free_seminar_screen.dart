import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:universe_soft_it/Asset_path/image_path.dart';
import 'package:universe_soft_it/component/bottom_app_bar.dart';
import 'package:universe_soft_it/constant/constant.dart';
import 'package:universe_soft_it/constant/constant_string.dart';
import 'package:universe_soft_it/presentation/free_seminar/controller/free_seminar_controller.dart';
import 'package:universe_soft_it/widget/custom_text_button.dart';
import 'package:universe_soft_it/widget/custom_text_filed.dart';
import 'package:universe_soft_it/widget/header.dart';
import 'package:http/http.dart' as http;
import 'package:universe_soft_it/widget/header2.dart';




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


      body: Container(
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
                  child:  Column(
                    children: [
                      SizedBox(height: 15.h,),
                      const Header2(),

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
                  Card(
                    elevation: 5,
                    child: Image.asset(
                      AssetPath.bifdtLogo,
                      height: 60.h,
                      width: 60.h,
                      fit: BoxFit.fill,
                    ),
                  ),
                   Text(
                    freeSeminarForm,
                    style: TextStyle(
                        fontSize: 27.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    fillupFreeSeminar,style: TextStyle(color: kPrimaryColor),),

                ],
              ),
            ),
             SizedBox(
              height: 15.h,
            ),

            Form(
              key: controller.formKey ,
              child: Column(
                children: [
                  SizedBox(height: 10.h,),
                  CustomTextField(controller: controller.nameController,

                      hintext: enterName,
                      bordercolor: Colors.black,
                    validator: (value){
                      if(value!.isEmpty){
                        return pleaseEnterName;

                      }
                      return null;

                    },
                  ),
                  SizedBox(height: 20.h,),
                  CustomTextField(
                      controller: controller.emailController,
                      hintext: enterEmail,
                      bordercolor: Colors.black,
                    validator: controller.validateEmail,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
                    child: DropdownButtonFormField(
                        value: selectedVal,
                        icon: const Icon(Icons.arrow_drop_down_circle),
                        dropdownColor: Colors.deepPurple.shade50,
                        decoration: const InputDecoration(
                          labelText: "Select Course",
                        ),
                        items: controller.courseList.map(
                                (e){
                              return DropdownMenuItem(value: e,child: Text(e),);
                            }
                        ).toList(),
                        onChanged: (val){
                          setState(() {
                            selectedVal = val!;
                          });

                        },
                      validator: (value){
                        if(value!.isEmpty){
                          return pleaseEnterCourse;

                        }
                        return null;

                      },

                    ),
                  ),
                  SizedBox(height: 10.h,),
              
                  CustomTextField(
                      controller:controller.numberController,
                      hintext: whatappNumber,
                      bordercolor: Colors.black,
                    validator: controller.validateNumber,
                  ),
                  SizedBox(height: 10.h,),
              
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.w),
                    child: DropdownButtonFormField(
                        value: selectedTypeVal,
                        isDense: true,
                        icon: const Icon(Icons.arrow_drop_down_circle),
                        dropdownColor: Colors.deepPurple.shade50,
                        decoration: const InputDecoration(
                          labelText: "Select Segment Type",
                        ),

                        items: controller.courseTypeList.map(
                                (b){
                              return DropdownMenuItem(value: b,child: Text(b),);
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
                    ),
                  ),
              

                  CustomTextButton(text: 'Submit', onTap: (){

                    if(controller.formKey.currentState!.validate()) {
                      freeSeminarRegister();


                      Future.delayed(const Duration(seconds: 1), () {
                        Fluttertoast.showToast(
                            msg: "Submit Successfully",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0.sp

                        );
                      });
                    }


                  }),
                ],
              ),
            ),








          ],

        ),
      ),
      bottomNavigationBar: const BottomApp(selectedItem: 3),

    );
  }

  void freeSeminarRegister()async{

      var url = "https://bifdt-server-ashikur.vercel.app/seminarRequest";
      var data = {
        "name":controller.nameController.text,
        "email": controller.emailController.text,
        "course": selectedVal.toString(),
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
      print(data2);





  }
}
