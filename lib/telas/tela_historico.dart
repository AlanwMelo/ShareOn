import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareon/layout_listas/lista_historico_builder.dart';
import 'package:shareon/utils/drawer_builder.dart';
import 'package:shareon/utils/shareon_appbar.dart';
import 'package:shareon/utils/texts.dart';

class TelaHistorico extends StatefulWidget {
  @override
  _TelaHistoricoState createState() => _TelaHistoricoState();
}

class _TelaHistoricoState extends State<TelaHistorico> {
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
      child: Column(
        children: <Widget>[
          textTitulo("Histórico"),
          Expanded(
            child: lista_historico_builder(),
          )
          ,
        ],
      ),
    ),
  );
}