


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:universe_soft_it/resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import 'package:universe_soft_it/resource/common_widget/screen_background.dart';
import 'package:universe_soft_it/repository/seminar_controller.dart';




import '../resource/constant.dart';

import '../resource/common_widget/loading_widget.dart';
import '../resource/common_widget/call_now_widget.dart';
import '../resource/common_widget/footer.dart';
import '../resource/common_widget/map_location.dart';
import '../resource/constant_string.dart';
import '../utils/routes/routes_name.dart';

class SeminarScreen extends StatelessWidget {
    SeminarScreen({super.key});

final controller = Get.put(SeminarController());

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
          child: ScreenBackground(child: Column(

            children: [

              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding:EdgeInsets.all(8.0.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25.h,),

                    Text(
                      freeSeminar,
                      style: TextStyle(
                          fontSize: 27.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5),
                    ),
                    const Text(
                      applySeminar,style: TextStyle(color: kPrimaryColor,fontFamily: "FontMain3",letterSpacing: 0.5),),

                  ],
                ),
              ),

              SizedBox(height: 15.h,),
              SizedBox(height: 440.h,
                child: FutureBuilder(
                  future: controller.getData(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData){
                      return ListView.separated(
                        itemCount: controller.seminar.length,
                        itemBuilder: (context, index) {
                          final seminar = controller.seminar[index];
                          return Container(
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(width: 2,color: Colors.blue),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(


                              leading: CircleAvatar(child: Text("${index+1}"),),
                              title: Text(seminar.topic.toString(),style:  TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold,fontFamily: "FontMain2",letterSpacing: 0.5),),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(seminar.date.toString(),style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold,fontFamily: "FontMain4",letterSpacing: 0.5),),
                                  Text(seminar.time.toString(),style: const TextStyle(fontSize: 11,fontWeight: FontWeight.bold,fontFamily: "FontMain4",letterSpacing: 0.5),),

                                ],
                              ),
                              trailing: InkWell(
                                onTap: (){
                                  Navigator.pushReplacementNamed(context, RouteName.freeSeminarScreen);
                                },
                                child: Container(
                                  height: 40.h,
                                  width: 120.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: kOrangeColor,
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                  child: Text(applyNow,style: TextStyle(color: Colors.white,fontSize: 14.sp),),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 1,),

                      );

                    }
                    else{
                      return const Center(child: CustomLoadingWidget());
                    }
                  },),),

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
          )),
        ),
        bottomNavigationBar: const BottomAppBarNavigation(selectedItem: 3),
      ),
    );
  }
}
