
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../resource/bottom_app_bar/bottom_navigation_app_bar.dart';
import '../resource/common_widget/screen_background_2.dart';
import '../view_model/login_view_model.dart';
import 'reigister_screen.dart';
import '../repository/login_controller.dart';



class LoginScreen1 extends StatelessWidget {
   LoginScreen1({super.key});


  final _numberTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = Get.put(LoginViewModel());


    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child:  Text(
                  "Welcome Back!",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2661FA),
                      fontSize: 36.sp
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: 5.h,),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child:  Text("Enter mobile number to login",style: TextStyle(fontSize: 16.sp,color: Colors.grey,fontWeight: FontWeight.w500),)),

              SizedBox(height: size.height * 0.03),

              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child:  Text(" Number*",style: TextStyle(fontSize: 16.sp,color: Colors.grey),)),
              SizedBox(height: 10.h,),
              Container(

                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: _numberTEController,
                  keyboardType: TextInputType.number,

                  decoration: InputDecoration(
                      hintText: "Enter Number",
                      hintStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: const Icon(Icons.call),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),

                      )
                  ),
                ),
              ),







              SizedBox(height: size.height * 0.03),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
                    padding: const EdgeInsets.all(0),

                  ),
                  onPressed: () async {
                    if(_numberTEController.text.isNotEmpty){
                      if(_numberTEController.text.length == 11)
                        {
                         final result = await controller.signIn(_numberTEController.text);
                         if (result) {
                           Get.offAll(()=> const BottomAppBarNavigation(selectedItem: 1,));
                         } else {

                           //showSnackBarMessage(context, _controller.errorMessage, true);
                           Get.showSnackbar(GetSnackBar(title:"Error",message: controller.errorMessage,duration: const Duration(seconds: 3),));
                         }
                        }
                      else{
                        Get.snackbar("Error", "Please enter 11 digit of number");

                      }

                    }
                    else{
                      Get.snackbar("Error", "Please enter number");
                    }
                  },

                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0.h,
                    width: size.width * 0.5,
                    decoration:  BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0.r),
                        gradient:  const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(0),
                    child: controller.inProgress? const Center(child: CircularProgressIndicator()):const Text(
                      "LOGIN",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()))
                  },
                  child: Text(
                    "Don't Have an Account? Sign up",
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2661FA)
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}