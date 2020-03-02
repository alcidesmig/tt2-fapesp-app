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
      home: Helper(),
    ),
  );
}

class Helper extends StatefulWidget {
  @override
  _Helper createState() => _Helper();

  Helper({Key key}) : super(key: key);
}

class _Helper extends State<Helper> {
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return (new Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            Icon(
              Icons.help,
              color: Colors.blue,
              size: 128.0,
            ),
            Text("\n\n\n  Como utilizar?\n"
                "  1. Conecte-se a rede Wi-fi de SSID: \"rasp\";\n"
                "  2. Inicie a missão no drone;\n"
                "  3. Aguarde o drone chegar no \"waypoint\" em questão;\n"
                "  4. Arraste para baixo na tela de dados para ter atualizar os dados.",
            style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold
                ),
            )
          ],
        ),

        )
    );
  }
}

