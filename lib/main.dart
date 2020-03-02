import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './data.dart';
import './write.dart';
import './help.dart';

void main() => runApp(MyApp());
//TODO: fonte
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Exemplo Drawer',
      theme: ThemeData(
        primarySwatch: Colors.blue, fontFamily: 'Roboto-Bold'
      ),
      home: MyHomePage(title: 'Drone - Visualização de dados'),
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
              child: Text('Cabeçalho'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('Item 1'),
              selected: 0 == _selectedIndex,
              onTap: () {
                _onSelectItem(0);
              },
            ),
            ListTile(
              title: Text('Item 2'),
              selected: 1 == _selectedIndex,
              onTap: () {
                _onSelectItem(1);
              },
            ),
            ListTile(
              title: Text('Ajuda'),
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