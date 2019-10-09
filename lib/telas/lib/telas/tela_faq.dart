import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shareon/telas/tela_main.dart';
import 'package:shareon/utils/texts.dart';

class TelaFAQ extends StatefulWidget {
  @override
  _TelaFAQState createState() => _TelaFAQState();
}


class _TelaFAQState extends State<TelaFAQ> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeFAQ(),
    );
  }
}

homeFAQ() {
  return Scaffold(
    body: SizedBox.expand(
      child: Container(
        color: Colors.grey[300],
        child: SingleChildScrollView(
          child: Container(
            height: 800,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(32),
                topLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
                bottomLeft: Radius.circular(32),
              ),
            ),
            child: Column(
              children: <Widget>[
                Container(
                  child: textTitulo("FAQ"),
                ),
                ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: double.infinity),
                  child: Container(
                    margin: EdgeInsets.only(
                      top: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _textFAQS("Pergunta 1", "Resposta"),
                        _textFAQS("Pergunta 2", "Resposta"),
                        _textFAQS("Pergunta 3", "Resposta"),
                        _textFAQS("Pergunta 4", "Resposta"),
                        _textFAQS("Pergunta 5", "Resposta"),
                        _textFAQS("Pergunta 6", "Resposta"),
                        _textFAQS("Pergunta 7", "Resposta"),
                        _textFAQS("Pergunta 8", "Resposta"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}


_textFAQS(String titulo, String resposta) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        child: Text(
          titulo,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
        ),
      ),
      Container(
        child: Text(
          resposta,
          style: TextStyle(
            color: Colors.black45,
          ),
        ),
      ),
    ],
  );
}
