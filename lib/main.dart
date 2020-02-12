import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

List<String> desc = [
  'Temperatura',
  'Velocidade indicada do ar',
  'Velocidade real do ar',
  'Umidade',
  'Bússola',
  'Latitude',
  'Longitude',
  'Altitude'
];

class SwipeToRefresh extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwipeToRefreshState();
  }
}

class _SwipeToRefreshState extends State<SwipeToRefresh> {

  SensorsData last_data = SensorsData("Nenhum valor lido ainda", "Nenhum valor lido ainda", "Nenhum valor lido ainda", "Nenhum valor lido ainda", "Nenhum valor lido ainda", "Nenhum valor lido ainda", "Nenhum valor lido ainda", "Nenhum valor lido ainda");

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  List<ListItem> items = List<ListItem>.generate(
    24,
    (i) => i % 8 == 0
        ? HeadingItem("Ponto de coleta: " + (i ~/ 8 + 1).toString())
        : MessageItem(desc[i % 8], "Nenhum valor lido ainda"),
  );

  String title = 'Drone - Visualização de dados';

  Widget buildBody(BuildContext context, int index) {
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
  }

  Future<Null> _refresh() {
    return getData().then((_last_data) {
      setState(() => last_data = _last_data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: RefreshIndicator(
          onRefresh: _refresh,
          key: _refreshIndicatorKey,
        child: ListView.builder(
          // Let the ListView know how many items it needs to build.
          itemCount: items.length,
          // Provide a builder function. This is where the magic happens.
          // Convert each item into a widget based on the type of item it is.
          itemBuilder: (BuildContext context, int index) =>
              buildBody(context, index),
        ),
        )
      ),
    );
  }
}

class SensorsData {
  final String temp,
      indicated_airspeed,
      true_airspeed,
      humidity,
      compass,
      lat,
      long,
      alt;

  SensorsData(this.temp, this.indicated_airspeed, this.true_airspeed,
      this.humidity, this.compass, this.lat, this.long, this.alt);

  factory SensorsData.fromJson(Map<String, dynamic> json) {
    // json = json['results'][0];
    String temp = json['temp'];
    String indicated_airspeed = json['indicated_airspeed'];
    String true_airspeed = json['true_airspeed'];
    String humidity = json['humidity'];
    String compass = json['compass'];
    String lat = json['lat'];
    String long = json['long'];
    String alt = json['alt'];
    return SensorsData(temp, indicated_airspeed, true_airspeed, humidity,
        compass, lat, long, alt);
  }
}

Future<SensorsData> getData() async {
  final response = await http.get("https://jsonplaceholder.typicode.com/posts");
  final responseJson = json.decode(response.body);
  return SensorsData.fromJson(responseJson);
}

void main() => runApp(SwipeToRefresh());

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
