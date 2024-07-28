

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:universe_soft_it/presentation/faculty/controller/faculty_controller.dart';


import '../../../constant/constant_string.dart';
import '../../../custom_widget/loading_widget.dart';



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
            Text(faculty,style: TextStyle(fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800
            )),

            TextButton(onPressed: (){

            }, child:  Text(seeAll,style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),))





          ],
        ),
         SizedBox(height: 10.h,),

        // Show our popular course
        SizedBox(
          height: 250.h,
          child: FutureBuilder(
            future: controller.getData(),
            builder: (context,snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.facultyMember.length,
                  itemBuilder: (context, index) {

                    return SizedBox(
                      width: 250.h,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),

                        ),
                        child: InkWell(
                          onTap: (){

                            // Here we will open details our page



                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //const SizedBox(height: 10,),
                              Image.network(controller.facultyMember[index].image.toString(),height: 170.h,width: 250.w,fit: BoxFit.fill,),
                              Column(


                                children: [
                                   SizedBox(height: 5.h,),
                                  Text(controller.facultyMember[index].name.toString(),style:  TextStyle(
                                    fontSize: 13.sp,fontWeight: FontWeight.bold,

                                  ),maxLines: 1,),
                                   SizedBox(height: 5.h,),
                                  Text(controller.facultyMember[index].designation.toString(),style:TextStyle(fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                  ),maxLines: 1,),






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