import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
 class YoutubeVideoPlayer extends StatefulWidget {
   String youtubeUrl;
    YoutubeVideoPlayer({super.key, required this.youtubeUrl});

 
   @override
   State<YoutubeVideoPlayer> createState() => _YoutubeVideoPlayerState();
 }
 
 class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {

   YoutubePlayerController? _controller;
   String? videoId;

   @override
  void initState() {

    super.initState();
    videoId = YoutubePlayer.convertUrlToId(widget.youtubeUrl);
    _controller = YoutubePlayerController(

        initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      )
    );
  }
   @override
   Widget build(BuildContext context) {
     return Container(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           IconButton(onPressed: (){
             Navigator.of(context).pop();

               }, icon: const Icon(Icons.dangerous_outlined,size: 38,color: Colors.white,)),
               const SizedBox(height: 5),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: YoutubePlayer(controller: _controller!),
           ),// Replace with your image path


         ],
       ),
     );
   }

 }
 