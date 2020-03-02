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


  SensorsData last_data = SensorsData([["Nenhum valor lido ainda","Nenhum valor lido ainda","Nenhum valor lido ainda"],["Nenhum valor lido ainda","Nenhum valor lido ainda","Nenhum valor lido ainda"],["Nenhum valor lido ainda","Nenhum valor lido ainda","Nenhum valor lido ainda"],["Nenhum valor lido ainda","Nenhum valor lido ainda","Nenhum valor lido ainda"],["Nenhum valor lido ainda","Nenhum valor lido ainda","Nenhum valor lido ainda"],["Nenhum valor lido ainda","Nenhum valor lido ainda","Nenhum valor lido ainda"],["Nenhum valor lido ainda","Nenhum valor lido ainda","Nenhum valor lido ainda"],["Nenhum valor lido ainda","Nenhum valor lido ainda","Nenhum valor lido ainda"]]);

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  static int cont = 0;
  List<ListItem> items = List<ListItem>.generate(
    27,
    (i) {
      if(i % 9 == 0) {
        return HeadingItem("Ponto de coleta: " + (i ~/ 10 + 1).toString());
      }
      return MessageItem(desc[cont++ % 8], "Nenhum valor lido ainda");
    }
  );


  String title = 'Drone - Visualização de dados';

  static int cont2 = 0;
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
      print(cont2.toString() + "\n");
      return ListTile(
        title: Text(item.sender),
        subtitle: Text(last_data.values[cont2 % 8][cont2++ ~/ 8]),
      );
    }
  }

   //TO DO: refatorar a classe para receber os dados dos 3 pontos como vetores de informações
   // TO DO: colocar botao att https://medium.com/flutterpub/adding-swipe-to-refresh-to-flutter-app-b234534f39a7


  Future<Null> _refresh() {
    return getData().then((_last_data) {
      this.setState(() => this.last_data = _last_data );
      print(last_data.values);
      cont2 = 0;
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

  final List<List<String>> values;


  SensorsData(this.values);

  factory SensorsData.fromJson(Map<String, dynamic> json) {
    String temp_0 = json['temp_0'] != null ? json['temp_0'] : "Nenhum valor lido ainda";
    String indicated_airspeed_0 = json['indicated_airspeed_0'] != null ? json['indicated_airspeed_0'] : "Nenhum valor lido ainda";
    String true_airspeed_0 = json['true_airspeed_0'] != null ? json['true_airspeed_0'] : "Nenhum valor lido ainda";
    String humidity_0 = json['humidity_0'] != null ? json['humidity_0'] : "Nenhum valor lido ainda";
    String compass_0 = json['compass_0'] != null ? json['compass_0'] : "Nenhum valor lido ainda";
    String lat_0 = json['lat_0'] != null ? json['lat_0'] : "Nenhum valor lido ainda";
    String long_0 = json['long_0'] != null ? json['long_0'] : "Nenhum valor lido ainda1";
    String alt_0 = json['alt_0'] != null ? json['alt_0'] : "Nenhum valor lido ainda1";

    String temp_1 = json['temp_1'] != null ? json['temp_1'] : "Nenhum valor lido ainda";
    String indicated_airspeed_1 = json['indicated_airspeed_1'] != null ? json['indicated_airspeed_1'] : "Nenhum valor lido ainda";
    String true_airspeed_1 = json['true_airspeed_1'] != null ? json['true_airspeed_1'] : "Nenhum valor lido ainda";
    String humidity_1 = json['humidity_1'] != null ? json['humidity_1'] : "Nenhum valor lido ainda";
    String compass_1 = json['compass_1'] != null ? json['compass_1'] : "Nenhum valor lido ainda";
    String lat_1 = json['lat_1'] != null ? json['lat_1'] : "Nenhum valor lido ainda";
    String long_1 = json['long_1'] != null ? json['long_1'] : "Nenhum valor lido ainda21";
    String alt_1 = json['alt_1'] != null ? json['alt_1'] : "Nenhum valor lido ainda21";

    String temp_2 = json['temp_2'] != null ? json['temp_2'] : "Nenhum valor lido ainda";
    String indicated_airspeed_2 = json['indicated_airspeed_2'] != null ? json['indicated_airspeed_2'] : "Nenhum valor lido ainda";
    String true_airspeed_2 = json['true_airspeed_2'] != null ? json['true_airspeed_2'] : "Nenhum valor lido ainda";
    String humidity_2 = json['humidity_2'] != null ? json['humidity_2'] : "Nenhum valor lido ainda";
    String compass_2 = json['compass_2'] != null ? json['compass_2'] : "Nenhum valor lido ainda";
    String lat_2 = json['lat_2'] != null ? json['lat_2'] : "Nenhum valor lido ainda";
    String long_2 = json['long_2'] != null ? json['long_2'] : "Nenhum valor lido ainda31";
    String alt_2 = json['alt_2'] != null ? json['alt_2'] : "Nenhum valor lido ainda31";

    var temp = [temp_0, temp_1, temp_2];
    var indicated_airspeed = [indicated_airspeed_0, indicated_airspeed_1, indicated_airspeed_2];
    var true_airspeed = [true_airspeed_0, true_airspeed_1, true_airspeed_2];
    var humidity = [humidity_0, humidity_1, humidity_2];
    var compass = [compass_0, compass_1, compass_2];
    var lat = [lat_0, lat_1, lat_2];
    var long = [long_0, long_1, long_2];
    var alt = [alt_0, alt_1, alt_2];


    return SensorsData([temp, indicated_airspeed, true_airspeed, humidity,
          compass, lat, long, alt]);
  }
}

Future<SensorsData> getData() async {
  final response = await http.get("https://raw.githubusercontent.com/alcidesmig/tt2-fapesp-app/master/teste.json");
  final responseJson = json.decode(response.body)[0];
  print(responseJson);
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
