

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:universe_soft_it/repository/faculty_controller.dart';
import 'package:universe_soft_it/view/faculty_details_screen.dart';
import 'package:universe_soft_it/view/home_screen.dart';

import '../resource/common_widget/loading_widget.dart';
import '../resource/constant_string.dart';



class Faculty extends StatefulWidget {
   const Faculty({super.key});

  @override
  State<Faculty> createState() => _FacultyState();
}

class _FacultyState extends State<Faculty> {

  final controller = Get.put(FacultyController());


  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(faculty,style: TextStyle(fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,fontFamily: "FontMain2",letterSpacing: 0.5
            )),

            TextButton(onPressed: (){
             // Navigator.push(context, MaterialPageRoute(builder: (context) => const AllFacultyMember(),));
              Get.toNamed('/allFacultyScreen');

            }, child:  Text(seeAll,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5),))





          ],
        ),
         SizedBox(height: 10.h,),

        // Show our popular course
        SizedBox(
          height: 240.h,
          child: FutureBuilder(
            future: controller.getData(),
            builder: (context,snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.facultyMember.length>10?10:controller.facultyMember.length,
                  itemBuilder: (context, index) {

                    return SizedBox(
                      width: 200.h,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),

                        ),
                        child: InkWell(
                          onTap: (){

                            Navigator.push(context, MaterialPageRoute(builder: (context) => FacultyDetails(faculty:controller.facultyMember[index], onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
                            }),));



                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             // SizedBox(height: 15.h,),
                              //const SizedBox(height: 10,),
                              SizedBox(
                                height:150.h,

                                child: Image.network(controller.facultyMember[index].image.toString(),height: 130.h, width: 200.h,fit: BoxFit.fill,),
                              ),
                              Column(


                                children: [
                                   SizedBox(height: 5.h,),
                                  Text(controller.facultyMember[index].name.toString(),style:  TextStyle(
                                    fontSize: 16.sp,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5

                                  ),maxLines: 1,),
                                  Text(controller.facultyMember[index].designation.toString(),style:TextStyle(fontSize: 13.sp,
                                      color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5
                                  ),maxLines: 1,),
                                  SizedBox(height: 3.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                       Text(experience,style:TextStyle(fontSize: 12.sp,
                                          fontWeight: FontWeight.w700)),
                                      Text(controller.facultyMember[index].jobExperience.toString(),style:TextStyle(fontSize: 12.sp,
                                          color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5
                                      ),maxLines: 1,),
                                      Text(plus,style:TextStyle(fontSize: 12.sp,
                                          fontWeight: FontWeight.w500)),
                                    ],
                                  ),






                                ],

                              ),

                            ],
                          ),
                        ),
                      ),
                    );

                  },
                );

              }
              else{
                return const CustomLoadingWidget();
              }

            }
          ),
        )
      ],
    );

  }


}