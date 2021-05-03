import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, "");
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    print("resultado digitado:" + query);

    List<String> list = [];
    Widget result;

    if (query.isNotEmpty) {
      list = ["Android", "Android navigation", "IOS", "Games"]
          .where((element) =>
              element.toLowerCase().startsWith(query.toLowerCase()))
          .toList();

      result = ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                close(context, list[index]);
              },
              title: Text(list[index]),
            );
          });
    } else {
      result = Center(
        child: Text("Nenhum resultado encontrado"),
      );
    }

    return result;
  }
}
