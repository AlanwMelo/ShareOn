import 'package:flutter/material.dart';
import 'package:shareon/listas/lista_main_builder.dart';
import 'package:shareon/utils/drawer_builder.dart';

home() {
  return Scaffold(
    // Navigation Drawer
    drawer: DrawerList(),
    appBar: AppBar(
      title: Text("Share On"),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.more_vert),
          onPressed: () {
            print("Icone");
          },
        )
      ],
    ),
    body: Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container (
            height: 50,
            color: Colors.red,
          ),
          Container(
            child: Expanded (
              child: lista_main_builder(),
            ),
          ),
        ],
      ),
    ),
  );
}

_text() {
  return Text(
    "Teste",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 30,
    ),
  );
}

_button() {
  return RaisedButton(
    child: Text("Botão"),
    onPressed: () {
      print("ok");
    },
  );
}
