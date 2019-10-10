// Classe que cria e gerencia as listas da tela principal

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareon/item_listas/lista_historico.dart';
import 'package:shareon/telas/produto_selecionado.dart';

lista_historico_builder() {
  List<Widget> _lista_historico = [
    lista_historico(),
    lista_historico(),
    lista_historico(),
  ];

  return ListView.builder(
    itemCount: _lista_historico.length,
    itemExtent: 150,
    itemBuilder: (BuildContext context, int index) {
      return GestureDetector(
        onTap: () => _OnClick(context),
        child: Container(
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
                          _textPreco(),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _textData(),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
_OnClick(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context){
    return ProdutoSelecionado();
  }));

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
        "https://i.pinimg.com/originals/64/82/0f/64820fd9ad5cce4b795ccf059e382f84.jpg",
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

_textData() {
  return Text(
    "12/01/2019",
    style: TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
  );
}

_textPreco() {
  return Text(
    "R\$ 45,00",
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
