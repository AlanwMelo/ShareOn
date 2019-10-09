import 'package:aplicativo_shareon/layout_listas/lista_historico_builder.dart';
import 'package:aplicativo_shareon/utils/drawer_builder.dart';
import 'package:aplicativo_shareon/utils/shareon_appbar.dart';
import 'package:aplicativo_shareon/utils/texts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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