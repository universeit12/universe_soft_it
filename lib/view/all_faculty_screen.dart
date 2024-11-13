import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:universe_soft_it/resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import 'package:universe_soft_it/view/faculty_details_screen.dart';
import '../resource/constant.dart';

import '../resource/common_widget/header1.dart';
import '../resource/common_widget/loading_widget.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../models/faculty_model.dart';
import '../resource/constant_string.dart';
import 'course_search_screen.dart';

import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';

class AllFacultyMember extends StatefulWidget {
  const AllFacultyMember({super.key});

  @override
  State<AllFacultyMember> createState() => _AllFacultyMemberState();
}

class _AllFacultyMemberState extends State<AllFacultyMember> {
  List <FacultyMemberModel> allFacultyList =[];
  List <FacultyMemberModel> showingFacultyList =[];


  @override
  void initState() {
    showingFacultyList = allFacultyList;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return Scaffold(
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
                  padding: EdgeInsets.symmetric(horizontal: 25.h,vertical: 10.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 30.w,),
                          const Header1(),
                        ],
                      ),
                      SizedBox(height: 9.2.h,),
                      CourseSearch(onchanged: (value){
                        if(value!.isNotEmpty){

                          setState(() {
                            showingFacultyList = allFacultyList.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();

                          });






                        }
                        else{
                          setState(() {
                            showingFacultyList = allFacultyList;
                          });


                        }


                      },hintext: searchForFacultyMember,),
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
                  child:  Center(child: Text(allFaculty,
                    style: TextStyle(fontSize: 30.sp,fontWeight: FontWeight.bold,color:Colors.white,fontFamily: "FontMain2",letterSpacing: 0.5),))),
            ),
            //SizedBox(height: 5.h,),

            SizedBox(
              height: 390.h,
              child: FutureBuilder(
                  future: getData(),
                  builder: (context,snapshot) {
                    if(snapshot.hasData){
                      return GridView.builder(
                        gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                        scrollDirection: Axis.vertical,
                        itemCount: showingFacultyList.length,
                        itemBuilder: (context, index) {
                          FacultyMemberModel data = showingFacultyList[index];
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

                                  // Here we will open details our page
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => FacultyDetails(faculty:data, onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AllFacultyMember(),));
                                  }),));



                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //SizedBox(height: 10.h,),

                                    SizedBox(
                                      height:125.h,

                                      child: Image.network(data.image.toString(),height: 125.h,width: 200.w,fit: BoxFit.fill,),
                                    ),
                                    Column(


                                      children: [

                                        Text(data.name.toString(),style:  TextStyle(
                                          fontSize: 15.sp,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5

                                        ),maxLines: 1,),
                                        Text(data.designation.toString(),style:TextStyle(fontSize: 13.sp,
                                            color: Colors.black,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5
                                        ),maxLines: 1,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(experience,style:TextStyle(fontSize: 11.sp,
                                                fontWeight: FontWeight.w700)),
                                            Text(data.jobExperience.toString(),style:TextStyle(fontSize: 11.sp,
                                                fontWeight: FontWeight.w700,
                                                color: Colors.black
                                            ),maxLines: 1,),
                                            Text(plus,style:TextStyle(fontSize: 11.sp,
                                                fontWeight: FontWeight.w700)),
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
            ),
            SizedBox(
              height: 20.h,
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
    );

  }
  Future<List<FacultyMemberModel>> getData()async{
    final response = await http.get(Uri.parse("$baseUrl/faculty"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        allFacultyList.add(FacultyMemberModel.fromJson(index));
      }
      return allFacultyList ;
    }
    else{
      return allFacultyList ;
    }
  }
}
