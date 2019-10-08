import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shareon/layout_listas/lista_main_builder.dart';
import 'package:shareon/utils/drawer_builder.dart';
import 'package:shareon/utils/shareon_appbar.dart';

class TelaMain extends StatefulWidget {
  @override
  _TelaMainState createState() => _TelaMainState();
}

class _TelaMainState extends State<TelaMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _home(),
    );
  }
}

_home() {
  return Scaffold(
    // Navigation Drawer
    drawer: DrawerList(),
    appBar: shareon_appbar(),
    body: Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(10),
            height: 50,
            color: Colors.indigo,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _icPesquisar(),
                      ],
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _icGPS(),
                    ],
                  ),
                ),
                Container(
                  child: Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        _icFiltros(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Expanded(
              child: lista_main_builder(),
            ),
          ),
        ],
      ),
    ),
  );
}

_icFiltros() {
  return Icon(
    Icons.filter_list,
    color: Colors.white,
    size: 30.0,
  );
}

_icPesquisar() {
  return Icon(
    Icons.search,
    color: Colors.white,
    size: 30.0,
    semanticLabel: 'Set Location',
  );
}

_icGPS() {
  return Icon(
    Icons.edit_location,
    color: Colors.white,
    size: 30.0,
    semanticLabel: 'Set Location',
  );
}