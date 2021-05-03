import 'package:http/http.dart' as http;
import 'dart:convert';

import 'model/Video.dart';

const CHAVE_YOUTUBE_API = "AIzaSyC_4hosxB0rCj9hXahcprUQx05BGg2uizU";
const ID_CANAL = "UCVHFbqXqoYvEWM1Ddxl0QDg";
const URL_BASE = "https://www.googleapis.com/youtube/v3/";

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    String url = URL_BASE +
        "search"
            "?part=snippet"
            "&type=video"
            "&maxResults=20"
            "&order=date"
            "&key=$CHAVE_YOUTUBE_API"
            "&channelId=$ID_CANAL"
            "&q=$pesquisa";

    print("URL: "+url);

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      Map<String, dynamic> dadosJson = json.decode(response.body);

      List<Video> videos = dadosJson["items"].map<Video>((map) {
        return Video.fromJson(map);
        //return Video.converterJson(map);
      }).toList();

      return videos;

      // for (var video in videos) {
      //   print("resultado: " + video.titulo);
      // }
      //print("Resultado: " + videos.toString() );

      /*
      for( var video in dadosJson["items"] ){
        print("Resultado: " + video.toString() );
      }*/
      //print("resultado: " + dadosJson["items"].toString() );

    } else {}
  }
}
