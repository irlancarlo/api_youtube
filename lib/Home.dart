import 'package:flutter/material.dart';
import 'package:youtube/telas/Biblioteca.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricoes.dart';

import 'CustomSearchDelegate.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _position = 0;
  static String _resultQuery = "";

  @override
  Widget build(BuildContext context) {

    List<Widget> screens = [
      Inicio(_resultQuery),
      EmAlta(),
      Inscricoes(),
      Biblioteca()
    ];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          "images/youtube.png",
          height: 22,
          width: 98,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        actions: [
          IconButton(onPressed: () async {
            String res = await showSearch(context: context, delegate: CustomSearchDelegate());
            print("resultado query: "+res);
            setState(() {
              _resultQuery = res;
            });
          }, icon: Icon(Icons.search)),
          // IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),          
          // IconButton(onPressed: () {}, icon: Icon(Icons.account_circle)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: screens[_position],
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.red,
        backgroundColor: Colors.white,
        // fixed - por padrão quando quantidade de items é menor que 4
        type: BottomNavigationBarType.fixed,
        // shifting - aplicado automaticamente quanto tem 4 ou items, aplicar o
        // background do BottomNavigationBarItem
        // type: BottomNavigationBarType.shifting,
        currentIndex: _position,
        onTap: (index) {
          setState(() {
            _position = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
            // só aparece com BottomNavigationBarType.shifting
            // backgroundColor: Colors.red
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.whatshot),
            label: "Em alta",
            // só aparece com BottomNavigationBarType.shifting
            // backgroundColor: Colors.black
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.subscriptions),
            label: "Incrições",
            // só aparece com BottomNavigationBarType.shifting
            // backgroundColor: Colors.blue
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.folder),
            label: "Biblioteca",
            // só aparece com BottomNavigationBarType.shifting
            // backgroundColor: Colors.pink
          ),
        ],
      ),
    );
  }
}
