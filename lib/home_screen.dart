import 'package:flutter/material.dart';
import 'package:project_one_advance/video_card.dart';
import 'package:project_one_advance/widgets/app_bar.dart';
import 'helpper/youtube_api_helpper.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const MyAppBar(),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 10, top: 10),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: 1,
                (context, index) {
                  return FutureBuilder(
                    future:
                        YouTubeAPIHelper.postAPIHelper.fetchingMultipleData(),
                    builder: (context, snapshot) {
                      List? data = snapshot.data;
                      if (snapshot.hasData) {
                        return SizedBox(
                          height: 740,
                          child: ListView.builder(
                            itemCount: data!.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => PlayVideo(url: data![index].userId,)),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image(
                                      image: NetworkImage(data![index].videoId),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data[index].title,
                                            maxLines: 2,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              Text(data[index].chanelTitle),
                                              const Spacer(),
                                              GestureDetector(
                                                onTap: () {},
                                                child: const Icon(Icons.more_vert,
                                                    size: 20.0),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text("${snapshot.error}"),
                        );
                      }
                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
