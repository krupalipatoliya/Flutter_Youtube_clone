import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'helpper/appRoutes.dart';
import 'helpper/youtube_api_helpper.dart';
import 'model/youtube_class.dart';
import 'play_page.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VideoScreen(url:url!),
    ),
  );
}

class VideoScreen extends StatefulWidget {
  VideoScreen({Key? key, required this.url}) : super(key: key);
  String url;
  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

late ChewieController chewieController1;
late VideoPlayerController videoPlayerController1;

TextEditingController searchcantroller = TextEditingController();

String? name;
String? url;

class _VideoScreenState extends State<VideoScreen> {
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
        automaticallyImplyLeading: true,
        centerTitle: true,
        backgroundColor: CupertinoColors.destructiveRed,
        title: const Text("Youtube Clone"),
        actions: [
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${name}"),
                ),
              );
            },
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextFormField(
                      controller: searchcantroller,
                      validator: (val) {
                        if (val!.isEmpty) {
                          return "Enter Search..";
                        }
                        return null;
                      },
                      onFieldSubmitted: (val) {
                        setState(() {
                          print(val);
                          name = val;
                        });
                      },
                      decoration: const InputDecoration(
                        label: Text("Search"),
                        hintText: "Enter Search",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
            FutureBuilder(
                future: YouTubeAPIHelper.postAPIHelper
                    .fetchingMultipleData(),
                builder: (context, snapshot) {
                  List? data = snapshot.data;
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("${snapshot.error}"),
                    );
                  } else if (snapshot.hasData) {
                    return SizedBox(
                      height: 600,
                      child: ListView.builder(
                        itemCount: data!.length,
                        itemBuilder: (context, index) => ListTile(
                          leading: Image(
                            image: NetworkImage(data[index].videoId),
                          ),
                          title: Text(data[index].title),
                          trailing: IconButton(
                            onPressed: () {

                              setState(() {
                                MyPAge();
                              });
                            },
                            icon: const Icon(Icons.play_arrow),
                          ),
                        ),
                      ),
                    );
                  }

                  return const Center(child: CircularProgressIndicator());
                }),
          ],
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


class MyPAge extends StatefulWidget {
  const MyPAge({Key? key}) : super(key: key);

  @override
  State<MyPAge> createState() => _MyPAgeState();
}

class _MyPAgeState extends State<MyPAge> {
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
