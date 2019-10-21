import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareon/item_listas/lista_avaliacoes.dart';
import 'package:shareon/telas/produto_selecionado.dart';

lista_avaliacoes_builder() {
  List<Widget> _lista_avaliacoes = [
    lista_avaliacoes(),
    lista_avaliacoes(),
    lista_avaliacoes(),
  ];

  position() {
    final listMap = _lista_avaliacoes.asMap();
    listMap.hashCode;
  }

  return ListView.builder(
    itemCount: _lista_avaliacoes.length,
    itemExtent: 10,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () => _OnClick(context),
        child: Text("AAAAAAAAAAAAAAAAAAAAA"),
      );
    },
  );
}

_OnClick(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
    return ProdutoSelecionado();
  }));
}
