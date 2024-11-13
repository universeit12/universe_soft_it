import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../resource/common_widget/screen_background_2.dart';
import 'login_screen1.dart';
import '../repository/signup_controller.dart';




class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = Get.put(SignUpController());



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
                child: Text(
                  "Create Account",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2661FA),
                      fontSize: 36.sp
                  ),
                  textAlign: TextAlign.left,
                ),
              ),

              SizedBox(height: size.height * 0.02),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(" Name*",style: TextStyle(fontSize: 16.sp,color: Colors.grey),)),
              SizedBox(height: 10.h,),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextFormField(
                  controller: controller.nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: "Enter Name",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: const Icon(Icons.person)

                  ),
                ),
              ),

              SizedBox(height: size.height * 0.01),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child:  Text(" Number*",style: TextStyle(fontSize: 16.sp,color: Colors.grey),)),
              SizedBox(height: 10.sp,),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller:controller.mobileController ,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Enter Mobile Number",
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      suffixIcon: const Icon(Icons.phone)
                  ),
                ),
              ),



              SizedBox(height: size.height * 0.05),

              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0.r)),
                    padding: const EdgeInsets.all(0),

                  ),
                  onPressed: () {
                    if(controller.nameController.text.isNotEmpty ){
                      if(controller.mobileController.text.isNotEmpty){
                        if(controller.mobileController.text.length == 11){
                          controller.registerApi(context);

                        }else{
                          Get.snackbar("Error", "Please enter 11 digits of number");

                        }

                      }
                      else{
                        Get.snackbar("Error", "Please enter a number");

                      }


                    }
                    else{
                      Get.snackbar("Error", "Please enter a name");
                    }
                  },

                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0.r),
                        gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 255, 136, 34),
                              Color.fromARGB(255, 255, 177, 41)
                            ]
                        )
                    ),
                    padding: const EdgeInsets.all(0),
                    child: controller.isLoading.value? const Center(child: CircularProgressIndicator()):const Text(
                      "SIGN UP",
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>  LoginScreen1()))
                  },
                  child: Text(
                    "Already Have an Account? Sign in",
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