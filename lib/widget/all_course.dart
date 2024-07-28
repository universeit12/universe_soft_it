import 'package:flutter/material.dart';
import 'package:universe_soft_it/component/bottom_app_bar.dart';


import '../argument/course_argument.dart';
import '../constant/constant.dart';
import '../data_provider/course_data_provider.dart';

import '../routes/routes_name.dart';

import 'course_search.dart';
import 'header.dart';
import 'header1.dart';

class AllPopularCourse extends StatelessWidget {
  const AllPopularCourse({super.key});

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
      
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  height: 170,
                  decoration: const BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25),
                      )
                  ),
                  child:  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25,vertical: 10),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Header1(),
                        SizedBox(height: 13,),
                        CourseSearch(),
                      ],
                    ),
                  )),
              const SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10,left: 2,right: 2),
                child: Container(
                  height: 50,
                    width: double.infinity,
                    color: kPrimaryColor,
                    child: const Center(child: Text("All Course",
                      style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Colors.white),))),
              ),
              const SizedBox(height: 10,),
              GridView.count(
                  crossAxisCount: 2,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                children: CourseDataProvider.courseList.map((course) {
                  return SizedBox(
                    width: 200,
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),

                      ),
                      child: InkWell(
                        onTap: (){

                          // Here we will open details our page
                          Navigator.pushNamed(context, RouteName.detailScreen,
                              arguments: CourseArgument(course)
                          );




                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(course.thumbnailUrl),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(course.title,style: TextStyle(fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade800
                                ),),
                                const SizedBox(height: 5,),
                                Row(
                                  children: [
                                    const Icon(Icons.person,color: kBlueColor,),
                                    const SizedBox(width: 5,),
                                    Text(course.createdBy,style: const TextStyle(fontSize: 12,color: kBlueColor),)
                                  ],
                                ),

                                const SizedBox(height: 5,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(Icons.star,size: 20,color: kRatingColor,),
                                        Text('${course.rate}',style: const TextStyle(fontSize: 15),)
                                      ],
                                    ),
                                    Text('৳ ${course.price}',style: TextStyle(fontSize: 15,
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
                
                }).toList(),
                
                
              ),
            ],
          ),
        ),
          bottomNavigationBar: const BottomApp(selectedItem: 2),
      ),
    );
  }
}
