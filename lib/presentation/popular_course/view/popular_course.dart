import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/constant/constant_string.dart';
import 'package:universe_soft_it/data_provider/course_data_provider.dart';
import 'package:universe_soft_it/model/course.dart';
import 'package:universe_soft_it/presentation/popular_course/controller/popular_course_controller.dart';
import 'package:universe_soft_it/presentation/popular_course/model/popular_course_model.dart';



import '../../../argument/course_argument.dart';
import '../../../constant/constant.dart';
import '../../../custom_widget/loading_widget.dart';
import '../../../routes/routes_name.dart';
import '../../../widget/all_course.dart';

class PopularCourse extends StatelessWidget {
  const PopularCourse({super.key});

  // Create sample data




  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PopularCourseController());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Our Popular Course",style: TextStyle(fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              color: Colors.grey.shade800
            )),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const AllPopularCourse(),));

              },
                child:  Text("See All",style: TextStyle(color: Colors.blue,fontSize: 17.sp),
                )),


          ],
        ),
         SizedBox(height: 10.h,),

        // Show our popular course
        SizedBox(
          height: 200.h,
          child: FutureBuilder(
            future: controller.getData(),
            builder: (context,snapshot) {
              if(snapshot.hasData){
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.popularCourseList.length,
                  itemBuilder: (context, index) {
                    PopularCourseModel data = controller.popularCourseList[index];
                    return SizedBox(
                      width: 200.w,
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),

                        ),
                        child: InkWell(
                          onTap: (){
                            /*

                            // Here we will open details our page
                            Navigator.pushNamed(context, RouteName.detailScreen,
                                arguments: CourseArgument(course)
                            );*/




                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(data.bannerImages![0].toString(),height: 100.h,width: double.infinity,fit: BoxFit.cover,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10.h,),
                                  Text(data.title.toString(),maxLines: 1,style: TextStyle(fontSize: 12.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey.shade800
                                  ),),
                                   SizedBox(height: 5.h,),
                                  Text(data.subtitle.toString(),maxLines: 2,
                                    style: TextStyle(
                                    fontSize: 12.sp,color: kBlueColor,

                                  ),),

                                  SizedBox(height: 5.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                       Text(price,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12.sp),),
                                      /*
                                      Row(
                                        children: [
                                           Icon(Icons.star,size: 20.sp,color: kRatingColor,),
                                          Text('${data.}',style:  TextStyle(fontSize: 15.sp),)
                                        ],
                                      ),*/
                                      Text('৳ ${data.courseFee.toString()}',style: TextStyle(fontSize: 12.sp,
                                          color: Colors.grey.shade800,
                                          fontWeight: FontWeight.bold
                                      ),)
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
