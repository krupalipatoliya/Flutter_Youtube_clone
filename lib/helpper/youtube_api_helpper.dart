import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/youtube_class.dart';

class YouTubeAPIHelper {
  YouTubeAPIHelper._();

  static final YouTubeAPIHelper postAPIHelper = YouTubeAPIHelper._();

  Future<List<dynamic>?> fetchingMultipleData({required String search}) async {


    http.Response response = await http.get(Uri.parse(
      "https://youtube.googleapis.com/youtube/v3/search?part=snippet&maxResults=20&q=$search&key=AIzaSyDS_XC-piBWMJOsOFLsXcaT1WqYHb0HB44"
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
