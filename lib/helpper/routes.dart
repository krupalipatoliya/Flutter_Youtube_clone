import 'package:flutter/cupertino.dart';

import '../main.dart';
import '../play_page.dart';
import 'appRoutes.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes().homePage: (context) => VideoScreen(url: 'jbj',),
  AppRoutes().play: (context) => VidioPlaying(url: url!,),
};
