import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './data.dart';
import './write.dart';
import './help.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exemplo Drawer',
      theme: ThemeData(
        primaryColor: Colors.black, fontFamily: 'Oxanium'
      ),
      home: MyHomePage(title: 'Drone - visualização de dados'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Column(
                      children: [Row(children: [Text('v1.0.0', style: TextStyle(color: Colors.white, fontSize: 64))]),
                                Row(crossAxisAlignment: CrossAxisAlignment.end, children: [Text('\nDesenvolvido por Alcides Mignoso e Luciano\nNeris', style: TextStyle(color: Colors.white, fontSize: 12))])]
                        ),
              decoration: BoxDecoration(
                color: Colors.black,
              ),
            ),
            ListTile(
              title: Text('- Leitura'),
              selected: 0 == _selectedIndex,
              onTap: () {
                _onSelectItem(0);
              },
            ),
            ListTile(
              title: Text('- Gravação'),
              selected: 1 == _selectedIndex,
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: Text('- Ajuda'),
              selected: 2 == _selectedIndex,
              onTap: () {
                _onSelectItem(2);
              },
            ),
          ],
        ),
      ),
      body: _getDrawerItem(_selectedIndex),
    );
  }

  _getDrawerItem(int pos) {
    switch (pos) {
      case 0:
        return SwipeToRefresh();
      case 1:
        return WriteData();
      case 2:
        return Helper();
    }
  }

  _onSelectItem(int index) {
    setState(() => _selectedIndex = index);
    Navigator.of(context).pop();
  }
}