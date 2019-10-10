import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareon/layout_listas/lista_favoritos_builder.dart';
import 'package:shareon/utils/texts.dart';

class TelaFavoritos extends StatefulWidget {
  @override
  _TelaFavoritosState createState() => _TelaFavoritosState();
}

class _TelaFavoritosState extends State<TelaFavoritos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeFavoritos(),
    );
  }
}

homeFavoritos() {
  return Scaffold(
    body: Container(
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
                      _text("Favoritos"),
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
          Expanded(
            child: lista_favoritos_builder(),
          )
          ,
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

_text(String x) {
  return Text(
    x,
    style: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}