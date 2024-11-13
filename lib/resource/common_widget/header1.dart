import 'package:flutter/material.dart';

import '../image_path_string.dart';


class Header1 extends StatelessWidget {
  const Header1({super.key});

  @override
  Widget build(BuildContext context) {
    return   Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(AssetPath.welcomeLogo,height: 95,width: 280,),
            //Text("Welcome BIFDT",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white,fontFamily: "FontMain2",letterSpacing: 0.5),),
           // SizedBox(height: 10,),
            //Text("Let's learn something new today!",style: TextStyle(fontSize: 18,color: Colors.white,fontFamily: "FontMain3",letterSpacing: 0.5),),
          ],
        ),




      ],
    );
  }
}
