


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:universe_soft_it/Asset_path/image_path.dart';
import 'package:universe_soft_it/presentation/seminar/controller/seminar_controller.dart';

import 'package:universe_soft_it/routes/routes_name.dart';

import '../../../component/bottom_app_bar.dart';
import '../../../constant/constant.dart';
import '../../../constant/constant_string.dart';
import '../../../custom_widget/loading_widget.dart';


import '../../../widget/header.dart';
import '../../../widget/header2.dart';

class SeminarScreen extends StatelessWidget {
    SeminarScreen({super.key});

final controller = Get.put(SeminarController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(

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
                    Card(
                      elevation: 5,
                      child: Image.asset(
                        AssetPath.bifdtLogo,
                        height: 60.h,
                        width: 60.w,
                        fit: BoxFit.fill,
                      ),
                    ),
                     Text(
                      freeSeminar,
                      style: TextStyle(
                          fontSize: 27.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      applySeminar,style: TextStyle(color: kPrimaryColor),),

                  ],
                ),
              ),

             SizedBox(height: 15.h,),

              SizedBox(
                height: 540.3.h,
                child: FutureBuilder(
                    future: controller.getData(),
                    builder: (context,snapshot) {
                      if(snapshot.hasData){
                        return GridView.builder(
                          itemCount: controller.seminar.length,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2),
                            itemBuilder: (context, index) {
                              return SizedBox(
                                width: 300.w,
                                child: Padding(
                                  padding: EdgeInsets.all(5.0.r),
                                  child: Card(
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 15,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.r),

                                    ),
                                    child: InkWell(
                                      onTap: (){

                                        // Here we will open details our page
                                        Navigator.pushReplacementNamed(context, RouteName.freeSeminarScreen);



                                      },
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                           SizedBox(height: 10.h,),
                                          Text(controller.seminar[index].topic.toString(),style: TextStyle(fontSize: 15.sp,
                                              fontWeight: FontWeight.bold),),
                                          Column(


                                            children: [
                                              SizedBox(height: 5.h,),
                                              Text(controller.seminar[index].time.toString(),style:  TextStyle(fontSize: 12.sp,fontWeight: FontWeight.bold),),
                                              SizedBox(height: 5.h,),
                                              Text(controller.seminar[index].date.toString(),style: TextStyle(fontSize: 10.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.grey.shade800
                                              ),),

                                               SizedBox(height: 20.h,),
                                               Text(applyNow,style: TextStyle(fontSize: 20.sp,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.blue
                                              ),),





                                            ],

                                          ),

                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );

                            },);

                      }
                      else{
                        return Center(child: const CustomLoadingWidget());
                      }

                    }
                ),
              )

            ],
          ),
        ),
        bottomNavigationBar: const BottomApp(selectedItem: 3),
      ),
    );
  }
}
