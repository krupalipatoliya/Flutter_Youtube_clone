import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/youtube_class.dart';

class YouTubeAPIHelper {
  YouTubeAPIHelper._();

  static final YouTubeAPIHelper postAPIHelper = YouTubeAPIHelper._();

  Future<List<dynamic>?> fetchingMultipleData() async {

    dynamic search = "songs";

    http.Response response = await http.get(Uri.parse(
      "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=10&q=song&key=AIzaSyDTIN4tXvlMj1hc-A8mrghv0OUGmZDo22o"
      ,
    ));

    if (response.statusCode == 200) {
      Map decodedData = jsonDecode(response.body);

      List i = decodedData['items'];

      List<dynamic> data = i.map((e) => YouTube.fromMap(data: e)).toList();

      return data;
    }
    return null;
  }
}
