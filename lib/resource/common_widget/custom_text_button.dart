import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universe_soft_it/resource/constant.dart';

class CustomTextButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final double height, width,fontSize;
  final bool isLoading;
  const CustomTextButton(
      {super.key,
      required this.text,
      required this.onTap,
       this.height =  50,
       this.width =  300, this.fontSize = 20,  this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height.h,
        width:width.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kOrangeColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: isLoading == false?Text(
          text!,
          style: TextStyle(
              fontSize: fontSize.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold),
        ):const CircularProgressIndicator(color: Colors.white,),
      ),
    );
  }
}
