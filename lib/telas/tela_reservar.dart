import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shareon/utils/shareon_appbar.dart';

class Tela_Reservar extends StatefulWidget {
  @override
  _Tela_ReservarState createState() => _Tela_ReservarState();
}

class _Tela_ReservarState extends State<Tela_Reservar> {
  @override
  Widget build(BuildContext context) {
    return _homeReservar();
  }

  _homeReservar() {
    return Scaffold(
      appBar: shareon_appbar(),
      backgroundColor: Colors.indigo,
      body: Container(
        margin: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            _text("Nome do produto", Titulo: true),
            Container(
              margin: EdgeInsets.only(top: 8, bottom: 8),
              child: _img(),
            ),
            _text(
                "Para reservar um produto você precisa informar a data e a hora que deseja utiliza-lo para checarmos sua disponibilidade."),
            Container(
              margin: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        width: 150,
                        child: RaisedButton(
                          onPressed: () {
                            _SelecionarData(context);
                          },
                          child: Text("Selecionar Data"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: _text("Data"),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: 150,
                        child: RaisedButton(
                          onPressed: () {
                            _SelecionarData(context);
                          },
                          child: Text("Selecionar Horário"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(8),
                        child: _text("Horario"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: _text("Valor estimado"),
            ),
            Container(
              margin: EdgeInsets.all(8),
              child: _text("R\$ 50,00"),
            ),
              Container(
                width: 500,
                margin: EdgeInsets.all(8),
                child: RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "Confirmar solicitação",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _SelecionarData(BuildContext context) async {
    final DateTime selecionado = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: new DateTime(2018),
      lastDate: new DateTime(2022),
    );
  }
}

_img() {
  return Container(
    child: ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 200,
        minHeight: 200,
        maxHeight: 200,
        maxWidth: 200,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(180),
        ),
        child: Container(
          child: Image.network(
            "https://avatars2.githubusercontent.com/u/49197693?s=400&v=4",
            fit: BoxFit.cover,
          ),
        ),
      ),
    ),
  );
}

_text(String texto, {bool Titulo = false, bool Resumo = false}) {
  if (Titulo == true) {
    return Text(
      "$texto",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 30,
      ),
    );
  } else if (Resumo == true) {
    return Text(
      "$texto",
      style: TextStyle(
        fontSize: 16,
      ),
    );
  } else {
    return Text(
      "$texto",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 20,
      ),
    );
  }
}
