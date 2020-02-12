import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {

  List<String> desc = ['Temperatura', 'Velocidade indicada do ar', 'Velocidade real do ar', 'Umidade', 'Bússola', 'Latitude', 'Longitude', 'Altitude'];

  int point = 1;

  runApp(MyApp(
    items: List<ListItem>.generate(
      24,
          (i) => i % 8 == 0
          ? HeadingItem("Ponto de coleta " + (point++).toString())
          : MessageItem(desc[i % 8], "Nenhum valor lido ainda"),
    ),
  ));
}

class MyApp extends StatelessWidget {
  final List<ListItem> items;

  MyApp({Key key, @required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final title = 'Drone - Visualização de dados';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (context, index) {
            final item = items[index];

            if (item is HeadingItem) {
              return ListTile(
                title: Text(
                  item.heading,
                  style: Theme.of(context).textTheme.headline,
                ),
              );
            } else if (item is MessageItem) {
              return ListTile(
                title: Text(item.sender),
                subtitle: Text(item.body),
              );
            }
          },
        ),
      ),
    );
  }
}

class DynamicListState extends State {
  @override
  Widget build(BuildContext context) {
    /*items.

    return Text(wordPair.asPascalCase);
  */}
}

class DynamicList extends StatefulWidget {
  @override
  DynamicListState createState() => DynamicListState();
}

// The base class for the different types of items the list can contain.
abstract class ListItem {}

// A ListItem that contains data to display a heading.
class HeadingItem implements ListItem {
  final String heading;

  HeadingItem(this.heading);
}

// A ListItem that contains data to display a message.
class MessageItem implements ListItem {
  final String sender;
  final String body;

  MessageItem(this.sender, this.body);
}


/*

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts"),
        headers: {"Accept": "application/json"});

    this.setState(() {
      data = json.decode(response.body);
    });
  }

  @override
  void initState() {
    this.getData();
  }

}

 */