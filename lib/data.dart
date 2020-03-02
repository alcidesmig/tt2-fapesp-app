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
  SensorsData data = SensorsData(
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      []);

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
  new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _refreshIndicatorKey.currentState.show());
  }

  //TO DO: refatorar a classe para receber os dados dos 3 pontos como vetores de informações
  // TO DO: colocar botao att https://medium.com/flutterpub/adding-swipe-to-refresh-to-flutter-app-b234534f39a7
  final snackBar = SnackBar(content: Text('Dados atualizados!'));
  Future<Null> _refresh() {
    Scaffold.of(context).showSnackBar(snackBar);

    return getData().then((_data) {
      this.setState(() => this.data = _data);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
            onRefresh: _refresh,
            key: _refreshIndicatorKey,
            child: Container(
                decoration: new BoxDecoration(
                  color: Colors.black,
                  image: new DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    image: new ExactAssetImage('img/back.jpg'),
                  ),
                ),
                child: GridView.count(
                // Create a grid with 2 columns. If you change the scrollDirection to
                // horizontal, this produces 2 rows.
                crossAxisCount: 2,
                // Generate 100 widgets that display their index in the List.
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('img/thermometer.png'),
                          height: 75,
                          width: 75,
                        ), Text(
                            ' ' + data.temp + '°C', style: TextStyle(color: Colors.yellow, fontSize: 32)
                        )
                      ]
                  ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Image(
                            image: AssetImage('img/compass.png'),
                            height: 75,
                            width: 75,
                        ), Text(
                          ' ' + data.compass + '°', style: TextStyle(color: Colors.yellow, fontSize: 32)
                        )
                    ]
                ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('img/height.png'),
                          height: 75,
                          width: 75,
                        ), Text(
                            ' ' + data.alt + 'm', style: TextStyle(color: Colors.yellow, fontSize: 32)
                        )
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('img/humidity.png'),
                          height: 75,
                          width: 75,
                        ), Text(
                            ' ' + data.humidity + '%', style: TextStyle(color: Colors.yellow, fontSize: 32)
                        )
                      ]
                  ), // Row
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('img/pin.png'),
                          height: 75,
                          width: 75,
                        ), Text(
                            ' ' + data.lat + 'N', style: TextStyle(color: Colors.yellow, fontSize: 32)
                        )
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('img/pin.png'),
                          height: 75,
                          width: 75,
                        ), Text(
                            ' ' + data.long+ 'S', style: TextStyle(color: Colors.yellow, fontSize: 32)
                        )
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('img/weather.png'),
                          height: 75,
                          width: 75,
                        ), Text(
                            ' ' + data.indicated_airspeed + '(i)', style: TextStyle(color: Colors.yellow, fontSize: 32)
                        )
                      ]
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('img/weather.png'),
                          height: 75,
                          width: 75,
                        ), Text(
                            ' ' + data.true_airspeed + '(t)', style: TextStyle(color: Colors.yellow, fontSize: 32)
                        )
                      ]
                  ),
                ]
          )
      )));
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
  final List<List<String>> values;

  SensorsData(this.temp, this.indicated_airspeed, this.true_airspeed,
      this.humidity, this.compass, this.lat, this.long, this.alt, this.values);


  factory SensorsData.fromJson(Map<String, dynamic> json) {
    String temp = json['temp'] != null ? json['temp'] : "???";
    String indicated_airspeed = json['indicated_airspeed'] != null ? json['indicated_airspeed'] : "???";
    String true_airspeed = json['true_airspeed'] != null ? json['true_airspeed'] : "???";
    String humidity = json['humidity'] != null ? json['humidity'] : "???";
    String compass = json['compass'] != null ? json['compass'] : "???";
    String lat = json['lat'] != null ? json['lat'] : "???";
    String long = json['long'] != null ? json['long'] : "???";
    String alt = json['alt'] != null ? json['alt'] : "???";


    return SensorsData(
      temp,
      indicated_airspeed,
      true_airspeed,
      humidity,
      compass,
      lat,
      long,
      alt, []);
  }
}

Future<SensorsData> getData() async {
  final response = await http.get(
      "https://raw.githubusercontent.com/alcidesmig/tt2-fapesp-app/master/teste.json");

  if (response.statusCode == 200) {
    // Ok response
    final responseJson = json.decode(response.body);
    return SensorsData.fromJson(responseJson);
  } else {
    throw Exception('Falha ao carregar JSON');
  }
}

