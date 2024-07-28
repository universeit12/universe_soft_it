import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:universe_soft_it/constant/constant.dart';

import '../component/bottom_app_bar.dart';
import '../model/course.dart';

class CourseDetails extends StatelessWidget {
  const CourseDetails({super.key, required this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {

     var grayStyle =  TextStyle(fontSize: 15,color: Colors.grey.shade600);
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.arrow_back,color: Colors.grey.shade800,),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.share,color: Colors.grey.shade800,),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.shopping_cart,color: Colors.grey.shade800,),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.asset(course.thumbnailUrl)),
                  const Column(
                    children: [
                      Icon(Icons.play_arrow,size: 90,color: Colors.white,),
                      SizedBox(height: 20,),
                      Text("Preview this course",style: TextStyle(fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30)
                ),
              ),

              child: Padding(
                padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                child: Column(
                children: [
                  Text(course.title,style: const TextStyle(fontSize: 21,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold),),

                  const SizedBox(height: 10,),

                     Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person,color: kBlueColor,),
                          const SizedBox(width: 10,),
                          Text(course.createdBy,style: const TextStyle(fontSize: 16,color: kBlueColor,
                            fontWeight: FontWeight.bold
                          ),)

                        ],
                      ),


                  ],),
                  Row(
                    children: [
                      Row(

                        children: [
                          const Icon(Icons.play_circle_outline),
                          const SizedBox(width: 10,),
                          Text("${course.lessonNo} Lessons",style: grayStyle,),
                        ],
                      ),

                      const SizedBox(width: 20,),
                      Row(

                        children: [
                          const Icon(Icons.access_time),
                          const SizedBox(width: 10,),
                          Text(course.duration,style: grayStyle,),
                        ],
                      ),

                      const SizedBox(width: 20,),
                      Row(

                        children: [
                          const Icon(Icons.star,color: Colors.yellow,),
                          const SizedBox(width: 10,),
                          Text("${course.rate}",style: grayStyle,),
                        ],
                      ),

                      const SizedBox(height: 10,),


                    ],
                  ),
                  const SizedBox(height: 10,),
                  ReadMoreText(course.description,
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: "Show more",
                    trimExpandedText: "Show less",
                    moreStyle: const TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),
                    lessStyle: const TextStyle(color: kBlueColor,fontWeight: FontWeight.bold),
                    style:  TextStyle(fontSize: 16,color: Colors.grey.shade800),
                  ),

                ],
              ),
            )),
          ],
        ),
        bottomNavigationBar: const BottomApp(selectedItem: 1,),
      ),
    );
  }
}
