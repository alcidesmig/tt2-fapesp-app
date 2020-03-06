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
      "-1",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
      "???",
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
                        ), Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [Text(
                                      ' ' + data.temp_1 + '°C', style: TextStyle(color: Colors.yellow, fontSize: 28)
                                  ), Text(
                                      ' ' + data.temp_2 + '°C', style: TextStyle(color: Colors.yellow, fontSize: 28)
                                  ), Text(
                                      ' ' + data.temp_3 + '°C', style: TextStyle(color: Colors.yellow, fontSize: 28)
                                  )]
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
                        ), Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [Text(
                              ' ' + data.compass_1 + '°', style: TextStyle(color: Colors.yellow, fontSize: 28)
                          ), Text(
                              ' ' + data.compass_2 + '°', style: TextStyle(color: Colors.yellow, fontSize: 28)
                          ), Text(
                              ' ' + data.compass_3 + '°', style: TextStyle(color: Colors.yellow, fontSize: 28)
                          )]
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
                        ), Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(
                                ' ' + data.alt_1 + 'm', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.alt_2 + 'm', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.alt_3 + 'm', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            )]
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
                        ), Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(
                                ' ' + data.humidity_1 + '%', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.humidity_2 + '%', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.humidity_3 + '%', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            )]
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
                        ), Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(
                                ' ' + data.lat_1 + 'N', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.lat_2 + 'N', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.lat_3 + 'N', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            )]
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
                        ), Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(
                                ' ' + data.long_1 + 'E', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.long_2 + 'E', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.long_3 + 'E', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            )]
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
                        ), Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(
                                ' ' + data.indicated_airspeed_1 + '(i)', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.indicated_airspeed_2 + '(i)', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.indicated_airspeed_3 + '(i)', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            )]
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
                        ), Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text(
                                ' ' + data.true_airspeed_1 + '(t)', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.true_airspeed_2 + '(t)', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            ), Text(
                                ' ' + data.true_airspeed_3 + '(t)', style: TextStyle(color: Colors.yellow, fontSize: 28)
                            )]
                        )
                      ]
                  ),
                ]
          )
      )));
  }

}

class SensorsData { // #TODO: transformar dados em vetores
  final String id_coleta,
      temp_1,
      indicated_airspeed_1,
      true_airspeed_1,
      humidity_1,
      compass_1,
      lat_1,
      long_1,
      alt_1,
      temp_2,
      indicated_airspeed_2,
      true_airspeed_2,
      humidity_2,
      compass_2,
      lat_2,
      long_2,
      alt_2,
      temp_3,
      indicated_airspeed_3,
      true_airspeed_3,
      humidity_3,
      compass_3,
      lat_3,
      long_3,
      alt_3;
  final List<List<String>> values;

  SensorsData(this.id_coleta,
      this.temp_1, this.indicated_airspeed_1, this.true_airspeed_1,
      this.humidity_1, this.compass_1, this.lat_1, this.long_1, this.alt_1,
      this.temp_2, this.indicated_airspeed_2, this.true_airspeed_2,
      this.humidity_2, this.compass_2, this.lat_2, this.long_2, this.alt_2,
      this.temp_3, this.indicated_airspeed_3, this.true_airspeed_3,
      this.humidity_3, this.compass_3, this.lat_3, this.long_3, this.alt_3, this.values);


  factory SensorsData.fromJson(Map<String, dynamic> json) {
    String id_coleta = json['id_coleta'] != null ? json['id_coleta'] : "???";

    String temp_1 = json['temp_1'] != null ? json['temp_1'] : "???";
    String indicated_airspeed_1 = json['indicated_airspeed_1'] != null ? json['indicated_airspeed_1'] : "???";
    String true_airspeed_1 = json['true_airspeed_1'] != null ? json['true_airspeed_1'] : "???";
    String humidity_1 = json['humidity_1'] != null ? json['humidity_1'] : "???";
    String compass_1 = json['compass_1'] != null ? json['compass_1'] : "???";
    String lat_1 = json['lat_1'] != null ? json['lat_1'] : "???";
    String long_1 = json['long_1'] != null ? json['long_1'] : "???";
    String alt_1 = json['alt_1'] != null ? json['alt_1'] : "???";

    String temp_2 = json['temp_2'] != null ? json['temp_2'] : "???";
    String indicated_airspeed_2 = json['indicated_airspeed_2'] != null ? json['indicated_airspeed_2'] : "???";
    String true_airspeed_2 = json['true_airspeed_2'] != null ? json['true_airspeed_2'] : "???";
    String humidity_2 = json['humidity_2'] != null ? json['humidity_2'] : "???";
    String compass_2 = json['compass_2'] != null ? json['compass_2'] : "???";
    String lat_2 = json['lat_2'] != null ? json['lat_2'] : "???";
    String long_2= json['long_2'] != null ? json['long_2'] : "???";
    String alt_2 = json['alt_2'] != null ? json['alt_2'] : "???";

    String temp_3 = json['temp_3'] != null ? json['temp_3'] : "???";
    String indicated_airspeed_3 = json['indicated_airspeed_3'] != null ? json['indicated_airspeed_3'] : "???";
    String true_airspeed_3 = json['true_airspeed_3'] != null ? json['true_airspeed_3'] : "???";
    String humidity_3 = json['humidity_3'] != null ? json['humidity_3'] : "???";
    String compass_3 = json['compass_3'] != null ? json['compass_3'] : "???";
    String lat_3 = json['lat_3'] != null ? json['lat_3'] : "???";
    String long_3= json['long_3'] != null ? json['long_3'] : "???";
    String alt_3 = json['alt_3'] != null ? json['alt_3'] : "???";


    return SensorsData(
        id_coleta,
        temp_1,
        indicated_airspeed_1,
        true_airspeed_1,
        humidity_1,
        compass_1,
        lat_1,
        long_1,
        alt_2,
        temp_2,
        indicated_airspeed_2,
        true_airspeed_2,
        humidity_2,
        compass_2,
        lat_2,
        long_2,
        alt_2,
        temp_3,
        indicated_airspeed_3,
        true_airspeed_3,
        humidity_3,
        compass_3,
        lat_3,
        long_3,
        alt_3,
        []);
  }
}

Future<SensorsData> getData() async {
  final response = await http.get("rasp.local");

  if (response.statusCode == 200) {
    // Ok response
    final responseJson = json.decode(response.body);
    return SensorsData.fromJson(responseJson);
  } else {
    throw Exception('Falha ao carregar JSON');
  }
}

