import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../image_path_string.dart';


class ScreenBackground extends StatelessWidget {
  const ScreenBackground({
    super.key, required this.child,
  });
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return SafeArea(
      child: Stack(
        children: [
          SvgPicture.asset(AssetPath.backgroundSvg,
            fit: BoxFit.cover,
            height: screenSize.height,
            width: screenSize.width,
          ),
          child,
      
      
        ],
      ),
    );
  }
}