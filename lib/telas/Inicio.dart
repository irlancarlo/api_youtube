import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class Inicio extends StatefulWidget {
  String _resultSearch;

  Inicio(String result) {
    this._resultSearch = result;
    print("_resultSearch: $_resultSearch");
  }

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideos(String search) {
    Api api = Api();
    return api.pesquisar(search);
  }

  @override
  void initState() {
    print("chamado 1 - initState");
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print("chamado 2 - didChangeDependencies");
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant Inicio oldWidget) {
    print("chamado 2 - didUpdateWidget");
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print("chamado 4 - dispose");
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("chamado 3 - build");

    // print("valor result: " + widget._resultSearch);

    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget._resultSearch),
      builder: (contex, snapshot) {
        Widget result;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              result = ListView.separated(
                  itemBuilder: (context, index) {
                    List<Video> videos = snapshot.data;
                    Video video = videos[index];

                    return GestureDetector(
                      onTap: () {
                        FlutterYoutube.playYoutubeVideoById(
                            apiKey: CHAVE_YOUTUBE_API, videoId: video.id, autoPlay: true, fullScreen: true);
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(video.imagem))),
                          ),
                          ListTile(
                            title: Text(video.titulo),
                            subtitle: Text(video.canal),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                  itemCount: snapshot.data.length);
            } else {
              result = Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
            break;
        }

        return result;
      },
    );
  }
}
