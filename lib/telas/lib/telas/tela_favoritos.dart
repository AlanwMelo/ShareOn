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
          textTitulo("Favoritos"),
          Expanded(
            child: lista_favoritos_builder(),
          )
          ,
        ],
      ),
    ),
  );
}

