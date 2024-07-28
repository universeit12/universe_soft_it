import 'dart:async';

import 'dart:convert';


import 'package:flutter/cupertino.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../custom_widget/loading_widget.dart';
import '../models/video_url_model.dart';
import '../youtube_player/youtube_player.dart';

class Offer extends StatefulWidget {
   const Offer({super.key});

  @override
  State<Offer> createState() => _OfferState();
}

class _OfferState extends State<Offer> {


  List <VideoUrlModel> videoList = [] ;
   late YoutubePlayerController _controller;

  String? videoId;
//"https://www.youtube.com/watch?v=vwgXidGwhhE"
  @override
  void initState() {
    super.initState();

      videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=vwgXidGwhhE");
      _controller = YoutubePlayerController(

        initialVideoId: videoId!, // Replace with your YouTube video ID
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
        ),
      );



  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// Lets move offer automatically with timer


  @override
  Widget build(BuildContext context) {
    return SizedBox(

      height: 200,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          FutureBuilder(
            future: getData(),
            builder: (context,snapshot) {
              if(snapshot.hasData){
                return  ListView.builder(
                  itemCount: videoList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            ClipRRect(
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                child: Image.network(videoList[index].imageUrl.toString(),height: 200,width: double.infinity,fit: BoxFit.fill,)),
                             Column(

                              children: [
                                GestureDetector(
                                  onTap:(){
                                    print(videoList[index].videoUrl.toString());
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => YoutubeVideoPlayer(youtubeUrl: "${videoList[index].videoUrl.toString()}")));
                                    
                                    }, 
                                    child: Icon(Icons.play_circle_outline_sharp,size: 70,color: Colors.white,)),

                              ],
                            )
                          ],
                        ),
                      );
                    },);


              }
              else {
                return Center(child: const CustomLoadingWidget());
              }

            }
          ),

        ],
      ),

    );
  }


  Future <List<VideoUrlModel>> getData()async{
    final response = await http.get(Uri.parse("https://bifdt-server-ashikur.vercel.app/homepageContent"));

    var data = jsonDecode(response.body.toString());

    if(response.statusCode == 200){
      for(Map<String, dynamic> index in data){
        videoList.add(VideoUrlModel.fromJson(index));
      }
      return videoList;
    }
    else{
      return videoList;
    }
  }
}
