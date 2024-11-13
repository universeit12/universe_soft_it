
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:universe_soft_it/repository/faculty_controller.dart';
import 'package:universe_soft_it/models/faculty_model.dart';
import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';
import '../resource/constant_string.dart';



class FacultyDetails extends StatelessWidget {


   FacultyDetails({super.key,required this.faculty,required this.onTap});


  final FacultyMemberModel faculty;


  final controller = Get.put(FacultyController());

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {




    return SafeArea(
      child: Scaffold(
        floatingActionButton: GestureDetector(
            onTap: (){
              CallNow.showDialog();
            },
            child: Lottie.asset("assets/images/offer/whatsapp1.json",height: 90,width: 90,)),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding:  EdgeInsets.all(8.0.r),
                      child: InkWell(
                          onTap:onTap,

                          child: Icon(Icons.arrow_back,color: Colors.grey.shade800,)),
                    ),
                    
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  height: 260.h,
                  width: 320.w,
                  child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),

                      ),
                      child: Image.network(faculty.image.toString(),fit: BoxFit.fill,)),
                ),
              ),
              SizedBox(height: 30.h,),
              Center(child: Text(teacherInformation ,style: TextStyle(fontSize: 23.sp,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5),)),
              const Padding(
                padding: EdgeInsets.only(left: 30,right: 30),
                child: Divider(thickness: 2,),
              ),
              SizedBox(height: 10.h,),
              Center(
                child: SizedBox(
                  width: 320.w,
                  child: Column(
                    children: [
                      Row(children: [
                        Text(nameInformation ,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,fontFamily: "FontMain2",letterSpacing: 0.5),),
                        Text(faculty.name.toString(),style: TextStyle(fontSize: 19.sp,fontWeight: FontWeight.w500,fontFamily: "FontMain2",letterSpacing: 0.5),),

                      ],),
                      Row(children: [
                        Text(emailInformation,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,fontFamily: "FontMain2",letterSpacing: 0.5),),
                        Text(faculty.email.toString(),style: TextStyle(fontSize: 19.sp,fontFamily: "FontMain2",letterSpacing: 0.5),maxLines: 1,),

                      ],),

                      Row(children: [
                        Text(designationInformation,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,fontFamily: "FontMain2",letterSpacing: 0.5),),
                        Text(faculty.designation.toString(),style: TextStyle(fontSize: 19.sp,fontFamily: "FontMain2",letterSpacing: 0.5),),

                      ],),
                      Row(children: [
                        Text(backGroundStudyInformation,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500,fontFamily: "FontMain2",letterSpacing: 0.5),),
                        Text(faculty.backgroundOfStudy.toString(),style: TextStyle(fontSize: 19.sp,fontFamily: "FontMain2",letterSpacing: 0.5),),

                      ],),
                      Row(children: [
                        Text(experienceInformation,style: TextStyle( fontSize: 20.sp,fontWeight: FontWeight.w500,fontFamily: "FontMain2",letterSpacing: 0.5),),
                        Text(faculty.jobExperience.toString(),style: TextStyle(fontSize: 19.sp,fontFamily: "FontMain2",letterSpacing: 0.5),),
                        Text(plus,style: TextStyle(fontSize: 19.sp,fontFamily: "FontMain2",letterSpacing: 0.5),),

                      ],),





                    ],
                  ),
                ),
              ),
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
        bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 0),
      ),

    );
  }
}
