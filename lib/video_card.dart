import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayVideo extends StatefulWidget {
  PlayVideo({Key? key, required this.url}) : super(key: key);

  String url;

  @override
  State<PlayVideo> createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late ChewieController chewieController1;
  late VideoPlayerController videoPlayerController1;

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("YouTube"),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Chewie(controller: chewieController1),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    videoPlayerController1.dispose();
    chewieController1.dispose();
  }
}
