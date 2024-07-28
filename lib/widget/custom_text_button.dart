import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:universe_soft_it/constant/constant.dart';

class CustomTextButton extends StatelessWidget {
  String? text;
  final VoidCallback? onTap;
  CustomTextButton({super.key, required this.text,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: 343.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: kOrangeColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(text!,style: TextStyle(fontSize: 20.sp,color: Colors.white,fontWeight: FontWeight.bold),),),
    );
  }
}
