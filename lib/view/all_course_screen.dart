import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:universe_soft_it/resource/bottom_app_bar/bottom_navigation_app_bar.dart';

import '../resource/constant.dart';

import '../resource/common_widget/header1.dart';
import '../resource/common_widget/loading_widget.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';
import '../models/popular_course_model.dart';
import '../resource/constant_string.dart';
import 'course_details_screen.dart';
import 'course_search_screen.dart';


class AllPopularCourse extends StatefulWidget {
  const AllPopularCourse({super.key});

  @override
  State<AllPopularCourse> createState() => _AllPopularCourseState();
}

class _AllPopularCourseState extends State<AllPopularCourse> {
  List <PopularCourseModel> popularCourseList =[];
  List <PopularCourseModel> showingProduct =[];


  @override
  void initState() {
    showingProduct = popularCourseList;
    super.initState();
  }
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
            children: [
              Container(
                  height: 170.h,
                  decoration: BoxDecoration(
                      color: kOrangeColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25.r),
                        bottomRight: Radius.circular(25.r),
                      )
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25,right: 25),
                    child: Column(
                      children: [
                        SizedBox(height: 5.h,),
                        Row(

                          children: [
                            SizedBox(width: 25.w,),
                            const Header1(),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                         CourseSearch(onchanged: (value){
                           if(value!.isNotEmpty){

                               setState(() {
                                 showingProduct = popularCourseList.where((element) => element.title!.toLowerCase().contains(value.toLowerCase())).toList();

                               });






                           }
                           else{
                             setState(() {
                               showingProduct = popularCourseList;
                             });


                           }


                         },hintext: searchForCourse,),
                      ],
                    ),
                  )),
               SizedBox(height: 10.h,),
              Padding(
                padding: EdgeInsets.only(top: 10.h,bottom: 5.h,left: 2.h,right: 2.h),
                child: Container(
                  height: 50.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: kOrangeColor,
                        borderRadius: BorderRadius.only(


                          topLeft: Radius.circular(25.r),

                          topRight:Radius.circular(25.r),
                        )
                    ),
                    child:  Center(child: Text(allCourse,
                      style: TextStyle(fontSize: 25.sp,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "FontMain2",letterSpacing: 0.5),))),
              ),
              SizedBox(height: 10.h,),


              SizedBox(
                height: 390.h,
                child: FutureBuilder(
                    future: getData(),
                    builder: (context,snapshot) {
                      if(snapshot.hasData){
                        return GridView.builder(

                          gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                          scrollDirection: Axis.vertical,

                          itemCount: showingProduct.length,
                          itemBuilder: (context, index) {
                            PopularCourseModel data = showingProduct[index];
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
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => CourseDetailsScreen(course: data)));

                                  },
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Image.network(data.bannerImages![0].toString(),height: 90.h,width: double.infinity,fit: BoxFit.cover,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 3.h,),
                                          Text(data.title.toString(),maxLines: 1,style: TextStyle(fontSize: 15.sp,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.grey.shade800,fontFamily: "FontMain2",letterSpacing: 0.5
                                          ),),

                                          Html(data: data.description,
                                            style: {
                                              "*": Style(
                                                maxLines: 1,
                                                textOverflow: TextOverflow.ellipsis,
                                                color: Colors.grey.shade800,
                                                fontSize: FontSize(14.0.sp),fontFamily: "FontMain2",letterSpacing: 0.5



                                              ),
                                            },
                                          ),

                                          SizedBox(height: 2.h,),
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
                                              SizedBox(width: 10.h,),

                                              Container(
                                                height: 28.h,width: 80.w,
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
                                                        fontSize: 13.sp),),
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
                        );

                      }
                      else{
                        return const CustomLoadingWidget();
                      }
                    }
                ),
              ),
              SizedBox(
                height: 10.h,
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
          bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 1),
      ),
    );

  }
  Future<List<PopularCourseModel>> getData()async{
    popularCourseList.clear();
    final response = await http.get(Uri.parse("$baseUrl/course"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        popularCourseList.add(PopularCourseModel.fromJson(index));
      }
      return popularCourseList;
    }
    else{
      return popularCourseList;
    }
  }
}
