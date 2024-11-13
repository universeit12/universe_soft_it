import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MapLocationSection extends StatelessWidget {
  const MapLocationSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Company Locations",
          style: TextStyle(
              fontSize: 25.sp,
              fontWeight: FontWeight.w800,
              fontFamily: "FontMain2",
              letterSpacing: 0.7,
              color: Colors.black38),
        ),
        SizedBox(
          height: 5.h,
        ),

        InkWell(
          onTap: () {
            // Navigate to the full-screen map image screen
            Get.to(() => const FullScreenMapScreen(imageUrl: "assets/images/offer/google_map.png"));
          },
          child: InteractiveViewer(
            minScale: 0.5,  // Minimum zoom level
            maxScale: 4.0,  // Maximum zoom level
            child: Card(
              color: Colors.white,
              clipBehavior: Clip.antiAlias,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                "assets/images/offer/google_map.png",
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
      ],
    );
  }
}




class FullScreenMapScreen extends StatelessWidget {
  final String imageUrl;

  const FullScreenMapScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          panEnabled: true, // Allow panning
          minScale: 0.5,    // Minimum zoom scale
          maxScale: 4.0,    // Maximum zoom scale
          child: Image.asset(
            imageUrl,
            height: 350,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
