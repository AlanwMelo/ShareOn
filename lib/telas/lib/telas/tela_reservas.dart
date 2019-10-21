import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareon/layout_listas/lista_reservas_builder.dart';
import 'package:shareon/utils/texts.dart';

class TelaReservas extends StatefulWidget {
  @override
  _TelaReservasState createState() => _TelaReservasState();
}

class _TelaReservasState extends State<TelaReservas> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeReservas(),
    );
  }
}

homeReservas() {
  return Scaffold(
    body: Container(
      child: Column(
        children: <Widget>[
          textTitulo("Reservas"),
          Expanded(
            child: lista_reservas_builder(),
          )
          ,
        ],
      ),
    ),
  );
}