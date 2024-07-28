



import 'package:get/get.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import 'package:universe_soft_it/Asset_path/image_path.dart';
import 'package:universe_soft_it/constant/constant_string.dart';
import 'package:universe_soft_it/presentation/login/controller/login_controller.dart';
import 'package:universe_soft_it/presentation/signup/view/sign_up_screen.dart';
import 'package:universe_soft_it/widget/custom_passwordform_field.dart';
import 'package:universe_soft_it/widget/custom_textform_field.dart';



class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  final controller = Get.put(LoginController());

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
                               borderRadius: BorderRadius.circular(200),
                             ),

                             child: Image.asset(AssetPath.bifdtLogo,height: 250.h,width: 250.w,fit: BoxFit.cover,)),
                       ),
                       Text(welcomeBifdt ,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.sp),),
                       const Text(enterMobile,style: TextStyle(color: Colors.white),),
                     ],
                   ),
                 ),





               ),
                SizedBox(height: 40.h,),

               Container(

                   margin:  const EdgeInsets.only(top: 20,left: 20,right: 30,bottom: 20),
                   child: Form(
                     key: controller.formKey,
                     child: Column(

                       children: <Widget>[
                         CustomTextFormField(controller: controller.mobileController, hintext: "Mobile Number",validator: controller.validateNumber,sufixIcon: Icon(Icons.phone),),
                          SizedBox(height: 10.h,),
                         CustomPasswordFormField(controller:controller.passController, hintext: "Password",validator: controller.isValidPassword,),
                        Obx(() => Padding(
                           padding:  EdgeInsets.only(top: 30.h),
                           child: CheckboxListTile(
                               title:  Text(saveMobilePass,style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w700,
                                   color: Colors.black38),),
                               value: controller.isChecked.value,
                               dense: true,
                               onChanged: (value){

                                     controller.isChecked.value = value!;



                               }),
                         )),

                         SizedBox(height: 80.h,),

                         InkWell(
                           onTap: (){
                             if (controller.formKey.currentState!.validate()) {
                               controller.loginApi(context);

                             }

                           },
                           child: Container(
                             margin:  EdgeInsets.only(top: 20.h),
                             width: double.infinity,
                             height: 45.h,
                             decoration: BoxDecoration(
                               gradient: const LinearGradient(colors: [Colors.orange, Colors.deepOrangeAccent],
                                 end:Alignment.centerLeft,
                                 begin: Alignment.centerRight,
                               ),
                               borderRadius: BorderRadius.all(Radius.circular(100.r)),
                             ),
                             alignment: Alignment.center,
                             child: Text(login,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20.sp),),
                           ),
                         ),

                         SizedBox(height: 110.h,),

                         InkWell(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context) =>  SignUpScreen(),));
                           },
                           child: RichText(text: const TextSpan(
                               children: [
                                 TextSpan(text: dontHaveAccount,style: TextStyle(color: Colors.black)),
                                 TextSpan(text: registerNow,style: TextStyle(color: Colors.orange)),
                               ]
                           )


                           ),
                         ),
                       ],
                     ),
                   )),


             ],
           ),
         ),
       ),
     );
   }


}
