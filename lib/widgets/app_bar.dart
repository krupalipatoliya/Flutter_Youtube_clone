import 'package:flutter/material.dart';
import '../main.dart';
import '../search_screen.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leadingWidth: 100.0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: Image.asset('assest/yt_logo_dark.png'),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.cast),
          onPressed: () {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: ListView.builder(
            //         itemCount: data.length,
            //         itemBuilder: (context, index) {
            //           return (data.isNotEmpty)
            //               ? Text(search[index])
            //               : const Text("Data not Found");
            //         }),
            //   ),
            // );

            print("Data ${data}");
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Searching List'),
                  content: SizedBox(
                    height: 100,
                    width: 200,
                    child: (data.isNotEmpty)
                        ? ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Text(data[index]);
                            })
                        : const Text("Data not Found"),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        IconButton(
          icon: const Icon(Icons.notifications_outlined),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
          },
        ),
      ],
    );
  }
}
