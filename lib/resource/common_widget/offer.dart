
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../view_model/home_content_view_model.dart';
import 'loading_widget.dart';
import 'youtube_player.dart';


class Offer extends StatelessWidget {
   Offer({super.key});

  final controller = Get.find<HomeContentViewModel>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: Obx(() =>Visibility(
        replacement: const Center(child: CustomLoadingWidget(),),
        visible: !controller.inProgress,
        child: ListView.builder(
          itemCount: controller.videoUrlImageList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final videoUrlImageList = controller.videoUrlImageList[index];
            return Stack(
              children: [
                ClipRRect(

                  borderRadius: BorderRadius.all(Radius.circular(10.r)),
                  child: Image.network(
                    videoUrlImageList.imageUrl.toString(),
                    height: 200.h,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ),
                Positioned(
                  left: 150,
                  bottom: 70,
                  child: GestureDetector(
                    onTap: () {
                      debugPrint(videoUrlImageList.videoUrl.toString());
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NetworkVideoPlayer(
                            videoUrl: videoUrlImageList.videoUrl.toString(),
                            autoplay: true,
                            isIconButton: true,
                          ),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.play_circle_outline_sharp,
                      size: 70.sp,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      )),
    );
  }
}
