import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: WriteData(),
    ),
  );
}

class WriteData extends StatefulWidget {

  WriteData({Key key}) : super(key: key);

  @override
  _WriteData createState() => _WriteData();
}

class _WriteData extends State<WriteData> {
  @override
  void initState() {
    super.initState();
  }

  _incrementCounter() async {
    var dir = await getApplicationDocumentsDirectory();
    await dir.create(recursive: true);
    var path = join(dir.path, 'teste.txt');
    final File file = File(path);
    await print(file.writeAsString("teste"));

  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Scaffold(
      body: Center(
        child: Text(
          'Button tapped ',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    ),
    margin: const EdgeInsets.all(10.0),
    padding: const EdgeInsets.all(10.0),
    decoration: new BoxDecoration(
    color: Colors.grey.shade200,
    borderRadius: new BorderRadius.all(new Radius.circular(5.0)),
    ));
  }
}