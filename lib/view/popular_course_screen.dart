
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/models/popular_course_model.dart';
import 'package:universe_soft_it/view_model/popular_course_view_model.dart';
import '../resource/constant.dart';
import '../resource/common_widget/loading_widget.dart';
import '../resource/constant_string.dart';
import 'all_course_screen.dart';
import 'course_details_screen.dart';

class PopularCourse extends StatelessWidget {
  const PopularCourse({super.key});



  // Create sample data
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PopularCourseViewModel>();


    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(ourPopularCourse,style: TextStyle(fontSize: 22.sp,
                fontWeight: FontWeight.bold,
              color: Colors.grey.shade800,fontFamily: "FontMain2",letterSpacing: 0.5
            )),

            TextButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPopularCourse(),));

            }, child:  Text(seeAll,style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5),))



          ],
        ),
         SizedBox(height: 10.h,),

        // Show our popular course
        SizedBox(
          height: 235.h,
          child:Obx(() =>  Visibility(
            replacement: const Center(child: CustomLoadingWidget(),),
            visible: !controller.inProgress,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.showingProduct.length>10?
              10: controller.showingProduct.length,
              itemBuilder: (context, index) {
                PopularCourseModel data = controller.showingProduct[index];
                return SizedBox(
                  width: 220.w,
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),

                    ),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailsScreen(course: data),));

                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.network(data.bannerImages![0].toString(),height: 100.h,width: double.infinity,fit: BoxFit.cover,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 5.h,),
                              Text(data.title.toString(),maxLines: 1,style: TextStyle(fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade800,fontFamily: "FontMain2",letterSpacing: 0.5
                              ),),

                              Html(data: data.description,
                                style: {
                                  "*": Style(
                                      maxLines: 2,
                                      textOverflow: TextOverflow.ellipsis,
                                      color: Colors.grey.shade800,
                                      fontSize: FontSize(12.0.sp),
                                      fontFamily: "FontMain4",
                                      letterSpacing: 0.5,
                                      fontWeight: FontWeight.bold



                                  ),
                                },
                              ),

                              SizedBox(height: 5.h,),
                              Row(

                                children: [
                                  SizedBox(width: 10.h,),
                                  Row(children: [
                                    Icon(Icons.star,size: 14.sp,color: Colors.orange,),
                                    Icon(Icons.star,size: 14.sp,color: Colors.orange,),
                                    Icon(Icons.star,size: 14.sp,color: Colors.orange,),
                                    Icon(Icons.star,size: 14.sp,color: Colors.orange,),
                                    Icon(Icons.star_half_sharp,size: 14.sp,color: Colors.orange,),
                                  ],),
                                  SizedBox(width: 25.h,),

                                  Container(
                                    height: 30.h,width: 95.w,
                                    decoration: BoxDecoration(
                                      color: kOrangeColor,
                                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                                    ),

                                    child: InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailsScreen(course: data),));

                                      },
                                      child:  Center(
                                        child: Text("Details",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,
                                            fontSize: 14.sp),),
                                      ),
                                    ),
                                  ),


                                ],
                              )

                            ],

                          ),

                        ],
                      ),
                    ),
                  ),
                );

              },
            ),
          )),
        ),

      ],
    );

  }


}
