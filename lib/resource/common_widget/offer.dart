import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import '../../models/video_url_model.dart';
import 'youtube_player.dart';
import 'loading_widget.dart';

class Offer extends StatefulWidget {
  const Offer({super.key});

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {
  List<VideoUrlModel> videoList = [];

  // Lets move offer automatically with timer

  Future<List<VideoUrlModel>> getData() async {
    try {
      final response = await http.get(Uri.parse("https://bifdt-server-ashikur.vercel.app/homepageContent"));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        if (data != null) {
          return (data as List).map((item) => VideoUrlModel.fromJson(item)).toList();
        }
      }
    } catch (e) {
      debugPrint('Error fetching data: $e');
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: FutureBuilder<List<VideoUrlModel>>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CustomLoadingWidget());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading videos'));
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            videoList = snapshot.data!;
            return ListView.builder(
              itemCount: videoList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ClipRRect(

                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      child: Image.network(
                        videoList[index].imageUrl.toString(),
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
                          debugPrint(videoList[index].videoUrl.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NetworkVideoPlayer(
                                videoUrl: videoList[index].videoUrl.toString(),
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
            );
          } else {
            return const Center(child: Text('No videos available'));
          }
        },
      ),
    );
  }
}
