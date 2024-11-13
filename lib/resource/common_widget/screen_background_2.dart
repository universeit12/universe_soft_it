import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/offer/top1.png",
                width: size.width
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset(
                "assets/images/offer/top2.png",
                width: size.width
            ),
          ),
          /* Positioned(
            top: 50,
            right: 30,
            child: Image.asset(
              "assets/images/main.png",
              width: size.width * 0.35
            ),
          ),*/
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/offer/bottom1.png",
                width: size.width
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
                "assets/images/offer/bottom2.png",
                width: size.width
            ),
          ),
          child
        ],
      ),
    );
  }
}