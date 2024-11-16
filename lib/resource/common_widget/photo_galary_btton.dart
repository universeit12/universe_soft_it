import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../view_model/student_photo_gallery_view_model.dart';



class PhotoGalleryButtons extends StatelessWidget {
  final  controller = Get.find<PhotoGalleryViewModel>();

   PhotoGalleryButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return Column(
          children: [
            // Category Buttons
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // "All Photos" Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        controller.selectCategory(''); // Empty string for all photos
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: controller.selectedCategory.value == ''
                            ? Colors.blue
                            : Colors.grey, // Highlight if "All Photos" is selected
                      ),
                      child: Text(
                        'All Photos',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "FontMain2",
                          letterSpacing: 0.5,
                          fontSize: 18.sp,
                        ),
                      ),
                    ),
                  ),
                  // Other Category Buttons
                  ...controller.categories.map((category) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          controller.selectCategory(category);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.selectedCategory.value == category
                              ? Colors.blue
                              : Colors.grey, // Highlight the selected category
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: "FontMain2",
                            letterSpacing: 0.5,
                            fontSize: 18.sp,
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            // Horizontal Image List
            SizedBox(
              height: 200.h,
              child: Obx(() {
                var images = controller.getImagesByCategory();
                if (images.isEmpty) {
                  return const Center(child: Text('No images found.'));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal, // Set scrolling direction to horizontal
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final image = images[index];
                    return GestureDetector(
                      onTap: () {
                        // Navigate to the full-screen image screen
                        Get.to(() => FullScreenImageScreen(imageUrl: image.image ?? ''));
                      },
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.network(
                          image.image ?? '',
                          fit: BoxFit.fill,
                          height: 200,
                          width: 280,
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        );
      }
    });
  }
}




class FullScreenImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullScreenImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
      
        body: Center(
          child: Stack(
            children: [
              Image.network(
                imageUrl,
                height: 320,
                width: double.infinity,
      
      
                fit: BoxFit.fill,
              ),
              Positioned(
                top: 20,
                  right: 20,
                  child: IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.close,color: Colors.white,size: 30,weight: 10,)))
            ],
          ),
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
