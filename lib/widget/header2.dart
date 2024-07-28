import 'package:flutter/material.dart';
import 'package:universe_soft_it/constant/constant.dart';

class Header2 extends StatelessWidget {
  const Header2({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Column(


      children: [
        Center(child: Text("Welcome BIFDT",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),)),
        SizedBox(height: 10,),
        Center(child: Text("Let's learn something new today!",style: TextStyle(fontSize: 18,color: Colors.white),)),
      ],
    );
  }
}
