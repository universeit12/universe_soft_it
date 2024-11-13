import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../image_path_string.dart';
import '../../repository/notification_controller.dart';
import '../../view/notification_screen.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    final NotificationController notificationController = Get.put(NotificationController());
    return  Row(



      children: [
         Column(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SizedBox(height: 10,),
            Row(
              children: [
                Image.asset(AssetPath.welcomeLogo,height: 85.h,width: 260.w,),
                SizedBox(width: 14.w,),

                Obx(() {
                  return InkWell(
                    onTap: (){
                      Get.to(() => NotificationScreen());
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Lottie.asset("assets/images/offer/notification3.json",height: 50,width: 54),/*

                          IconButton(
                            icon: const Icon(Icons.notifications,color: Colors.white,size: 30,),
                            onPressed: () {
                              Get.to(() => NotificationScreen());
                            },
                          ),
                          */
                          if (notificationController.notificationCount.value > 0)
                            Positioned(
                              right: 11,
                              top: 11,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 14,
                                  minHeight: 14,
                                ),
                                child: Text(
                                  '${notificationController.notificationCount}',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w600
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                })
   /*
                Row(
                  children: [
                    Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                          color: kOrangeColor,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child:  Align(
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Builder(
                                builder: (context) {
                                  return InkWell(
                                    onTap: ()=> Scaffold.of(context).openEndDrawer(),
                                      child: Lottie.asset("assets/images/offer/notification3.json",height: 200,width: 200),);

                                    /*IconButton(
                                      onPressed: ()=> Scaffold.of(context).openEndDrawer(),
                                      icon:  const Icon(Icons.notifications,color: Colors.white));*/
                                }
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),*/
              ],
            ),
            //Text("Welcome BIFDT",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "FontMain2",letterSpacing: 1),),

            //Text("Let's learn something new today!",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: "FontMain3"),),
          ],
        ),




      ],
    );
  }
}
