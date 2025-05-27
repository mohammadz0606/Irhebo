import 'package:flutter/material.dart';
import 'package:irhebo/presentation/widgets/app_loading.dart';
import 'package:video_player/video_player.dart';

class VideoMediaWidget extends StatefulWidget {
  final String mediaUrl;
  const VideoMediaWidget({super.key, required this.mediaUrl});

  @override
  State<VideoMediaWidget> createState() => _VideoMediaWidgetState();
}

class _VideoMediaWidgetState extends State<VideoMediaWidget> {
  late VideoPlayerController _controller;

  // VideoPlayerController controller = VideoPlayerController.networkUrl(
  //     Uri.parse("https://www.youtube.com/watch?v=TO-_3tck2tg"));
  bool isInitialized = false;
  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.mediaUrl))
      ..initialize().then((_) {
        isInitialized = true;
        setState(() {
          _controller.play();
        });
      }).catchError((e) {
        print('VIDEO $e');
      });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;

    return isInitialized
        ? AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller))
        : AppLoading(
            height: (1 * w) / 1.11,
            width: 1 * w,
            radius: 0,
          );
  }
}
