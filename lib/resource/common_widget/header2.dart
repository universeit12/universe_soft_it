import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../image_path_string.dart';



class Header2 extends StatelessWidget {
  const Header2({super.key});

  @override
  Widget build(BuildContext context) {
    return   Column(


      children: [
        SizedBox(height: 10.h,),
        Image.asset(AssetPath.welcomeLogo,height: 85.h,width: 280.w,),
        Center(child: Text("Let's learn something new today!",style: TextStyle(fontSize: 23.sp,color: Colors.white,fontFamily: "FontMain2",letterSpacing: 0.5),)),
      ],
    );
  }
}
