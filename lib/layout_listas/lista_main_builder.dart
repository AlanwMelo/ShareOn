// Classe que cria e gerencia as listas da tela principal

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareon/item_listas/lista_main.dart';

lista_main_builder() {
  List<Widget> _lista_main = [
    lista_main(),
    lista_main(),
    lista_main(),
    lista_main(),
    lista_main(),
    lista_main(),
    lista_main(),
    lista_main(),
    lista_main(),
    lista_main(),
    lista_main(),
  ];

  return ListView.builder(
    itemCount: _lista_main.length,
    itemExtent: 150,
    itemBuilder: (BuildContext context, int index) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        margin: EdgeInsets.all(6),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _img(),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    _textNome(),
                    Row(
                      children: <Widget>[
                        _textMedia(),
                        _iconEstrela(),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        _textDistancia(),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  _textPreco(),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}
//objetos

_img() {
  return ClipRRect(
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16),
        topRight: Radius.zero,
        bottomRight: Radius.zero,
        bottomLeft: Radius.circular(16)),
    child: Container(
      child: Image.network(
        "https://cdn.thewirecutter.com/wp-content/uploads/2018/06/cataccessories-lowres-2x1-05916.jpg",
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    ),
  );
}

_textNome() {
  return Text(
    "Nome",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 26,
      color: Colors.indigo,
    ),
  );
}

_textMedia() {
  return Text(
    "5.0",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );
}

_textDistancia() {
  return Text(
    "400m",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );
}

_textPreco() {
  return Text(
    "45,00",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 18,
    ),
  );
}

_iconEstrela(){
  return Icon(
    Icons.star,
    color: Colors.black,
    size: 20.0,
  );
}
