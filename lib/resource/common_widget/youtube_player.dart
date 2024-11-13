import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:video_player/video_player.dart'; // Import for network video player

class NetworkVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final bool autoplay;
  final bool isIconButton;
  final double? width, iconSize; // Adjustable width
  final double? height; // Adjustable height
  final BoxFit? fit; // Adjustable fit for network videos

  const NetworkVideoPlayer({
    super.key,
    required this.videoUrl,
    this.autoplay = false,
    this.isIconButton = false,
    this.width, // Allow customization
    this.height, // Allow customization
    this.fit = BoxFit.cover,
    this.iconSize = 48, // Default fit to cover
  });

  @override
  State<NetworkVideoPlayer> createState() => _NetworkVideoPlayerState();
}

class _NetworkVideoPlayerState extends State<NetworkVideoPlayer> {
  YoutubePlayerController? _youtubeController;
  VideoPlayerController? _networkController;
  String? videoId;
  bool isYoutubeVideo = false;

  @override
  void initState() {
    super.initState();

    // Try to extract the YouTube video ID.
    videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    debugPrint("----------------------");
    debugPrint(widget.videoUrl.toString());
    if (videoId != null) {
      // If a valid YouTube ID is found, set up the YouTube player.
      isYoutubeVideo = true;
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: YoutubePlayerFlags(
          autoPlay: widget.autoplay,
          mute: false,
          controlsVisibleAtStart: true,
        ),
      );
    } else {
      // If it's not a YouTube video, use the new VideoPlayerController.networkUrl for network videos.
      _networkController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
        ..initialize().then((_) {
          if (widget.autoplay) {
            _networkController!.play();
          }
          setState(() {}); // Trigger a rebuild to show the video after it is initialized
        });
    }
  }

  @override
  void dispose() {
    // Dispose both controllers when not needed.
    _youtubeController?.dispose();
    _networkController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          // Show an IconButton if isIconButton is true, otherwise show nothing.
          Padding(
            padding: const EdgeInsets.all(8.0),
            // Check if it's a YouTube video or a network video and show the appropriate player.
            child: SizedBox(
              width: widget.width ?? double.infinity,
              height: widget.height ?? 250.h, // Set default height for video
              child: isYoutubeVideo
                  ? YoutubePlayer(
                controller: _youtubeController!,
                width: widget.width ?? double.infinity, // Adjust the width
                aspectRatio: 16 / 9, // Set a default aspect ratio
              )
                  : _networkController != null && _networkController!.value.isInitialized
                  ? AspectRatio(
                aspectRatio: _networkController!.value.aspectRatio,
                child: FittedBox(
                  fit: widget.fit ?? BoxFit.cover, // Control how the video fits
                  child: SizedBox(
                    width: _networkController!.value.size.width,
                    height: _networkController!.value.size.height,
                    child: VideoPlayer(_networkController!),
                  ),
                ),
              )
                  : const Center(child: Text("Loading video...",style: TextStyle(fontSize: 30),)),
            ),
          ),
          widget.isIconButton
              ? Positioned(
            right: 20,
            top: 7,
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.dangerous_outlined,
                size: widget.iconSize,
                color: Colors.white,
              ),
            ),
          )
              : const SizedBox(),
        ],
      ),
    );
  }
}
