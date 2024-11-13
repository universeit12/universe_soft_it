import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CourseSearch extends StatelessWidget {
  final void Function(String?)? onchanged;
  final void Function()? onTap;
  final String? hintext;

   const CourseSearch({super.key, this.onchanged, this.onTap, required this.hintext});

  @override
  Widget build(BuildContext context) {
    return TextField(

      onChanged: onchanged,
      onTap: onTap,
      autofocus: false,
      decoration: InputDecoration(
        hintText: hintext,
        hintStyle: TextStyle(color: Colors.grey.shade400,fontFamily: "FontMain3"),
        prefixIcon:  Padding(
          padding:  EdgeInsets.only(left: 10.h),
          child: Icon(Icons.search,size: 20.h,),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
        contentPadding:  EdgeInsets.fromLTRB(10.h, 10.h, 10.h, 10.h),
        filled: true,
        fillColor: Colors.white
      ),
    );
  }
}
