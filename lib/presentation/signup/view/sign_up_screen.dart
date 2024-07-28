
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:universe_soft_it/Asset_path/image_path.dart';

import 'package:universe_soft_it/widget/custom_textform_field.dart';


import '../../../constant/constant_string.dart';
import '../../login/view/login_screen.dart';
import '../controller/signup_controller.dart';

class SignUpScreen extends StatelessWidget {
   SignUpScreen({super.key});

  final controller = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(bottom: 30.h),
          child: Column(
            children: <Widget>[

              Container(

                height: MediaQuery.of(context).size.height*0.3,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrangeAccent],
                    end:Alignment.bottomCenter,
                    begin: Alignment.topCenter,
                  ),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.r)),
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: 50.h,),
                      SizedBox(
                        width: 100.w,
                        height: 100.h,
                        child: Card(

                            elevation: 200,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(200.r),
                            ),

                            child: Image.asset(AssetPath.bifdtLogo,height: 250.h,width: 250.w,fit: BoxFit.cover,)),
                      ),
                       Text(createAccount,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.sp),),
                      const Text(signContinue,style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),





              ),
              SizedBox(height: 70.h,),

              Container(

                  margin: EdgeInsets.only(top: 20.h,left: 20.h,right: 30.h,bottom: 20.h),
                  child: Column(

                    children: <Widget>[
                      CustomTextFormField(controller: controller.nameController, hintext: enterName,sufixIcon: const Icon(Icons.person),validator: controller.validateName),
                       SizedBox(height: 5.h,),
                      CustomTextFormField(controller: controller.mobileController, hintext: enterNumber,sufixIcon: const Icon(Icons.phone),validator: controller.validateNumber,),
                       SizedBox(height: 5.h,),



                      SizedBox(height: 60.h,),

                      Container(
                        margin:  EdgeInsets.only(top: 20.h),
                        width: double.infinity,
                        height: 45.h,
                        decoration:  BoxDecoration(
                          gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrangeAccent],
                            end:Alignment.centerLeft,
                            begin: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(100.r)),
                        ),
                        alignment: Alignment.center,
                        child:  Text(signUp,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),),
                      ),

                      SizedBox(height: 185.h,),

                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
                        },
                        child: RichText(text: const TextSpan(
                            children: [
                              TextSpan(text: alreadyHaveAccount,style: TextStyle(color: Colors.black)),
                              TextSpan(text: loginNow,style: TextStyle(color: Colors.orange)),
                            ]
                        )


                        ),
                      ),
                    ],
                  )),


            ],
          ),
        ),
      ),
    );
  }


}
