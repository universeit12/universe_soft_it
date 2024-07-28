import 'package:flutter/material.dart';
import 'package:universe_soft_it/constant/constant.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Welcome BIFDT",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.white),),
            SizedBox(height: 10,),
            Text("Let's learn something new today!",style: TextStyle(fontSize: 18,color: Colors.white),),
          ],
        ),

        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: const BoxDecoration(
                color: kOrangeColor,
                borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              child:  Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Builder(
                      builder: (context) {
                        return IconButton(
                          onPressed: ()=> Scaffold.of(context).openEndDrawer(),
                            icon:  const Icon(Icons.notifications,color: Colors.white));
                      }
                    ),

                  ],
                ),
              ),
            )
          ],
        )


      ],
    );
  }
}
