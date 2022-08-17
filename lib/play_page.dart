import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'main.dart';

class VidioPlaying extends StatefulWidget {
  VidioPlaying({Key? key, required this.url}) : super(key: key);

  String url;

  @override
  State<VidioPlaying> createState() => _VidioPlayingState();
}

class _VidioPlayingState extends State<VidioPlaying> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    videoPlayerController1 = VideoPlayerController.network(
        "https://www.youtube.com/watch?v=${widget.url}")
      ..initialize().then((value) => setState(() {}));

    chewieController1 = ChewieController(
      videoPlayerController: videoPlayerController1,
      looping: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AspectRatio(
            aspectRatio: 16 / 9, child: Chewie(controller: chewieController1)),
        const SizedBox(
          height: 15,
        ),
        const Text(
          "My title",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Text(
          "My Subtitle",
          style: TextStyle(
            fontSize: 15,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
