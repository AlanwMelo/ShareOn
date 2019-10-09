import 'package:aplicativo_shareon/utils/drawer_builder.dart';
import 'package:aplicativo_shareon/utils/shareon_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaSuporte extends StatefulWidget {
  @override
  _TelaSuporteState createState() => _TelaSuporteState();
}

class _TelaSuporteState extends State<TelaSuporte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _home(),
    );
  }
}

_home() {
  return Scaffold(
    appBar: shareon_appbar(),
    drawer: DrawerList(),
    body: Container(
      child: Center(
        child: Text("Suporte"),
      ),
    ),
  );
}
