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
      body: homeSuporte(),
    );
  }
}

homeSuporte() {
  return Scaffold(
    body: Container(
      child: Center(
        child: Text("Suporte"),
      ),
    ),
  );
}
