import 'package:aplicativo_shareon/telas/tela_chat.dart';
import 'package:aplicativo_shareon/telas/tela_dicas.dart';
import 'package:aplicativo_shareon/telas/tela_faq.dart';
import 'package:aplicativo_shareon/telas/tela_favoritos.dart';
import 'package:aplicativo_shareon/telas/tela_historico.dart';
import 'package:aplicativo_shareon/telas/tela_main.dart';
import 'package:aplicativo_shareon/telas/tela_reservas.dart';
import 'package:aplicativo_shareon/telas/tela_suporte.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerList extends StatefulWidget {
  @override
  _DrawerListState createState() => _DrawerListState();
}

class _DrawerListState extends State<DrawerList> {

  int screenPointer = 0;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _cabecalho(),
                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        _corpo(),
                      ],
                    ),
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  _img() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(180),
      ),
      child: Container(
        child: Image.network(
          "https://graph.facebook.com/2245836778831674/picture?type=large",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _textnome() {
    return Text(
      "Alan Willian",
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _textemail() {
    return Text(
      "amelo967@gmail.com",
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _cabecalho() {
    return Container(
      color: Color.fromARGB(255, 3, 50, 92),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: Container(
              height: 150,
              width: 150,
              margin: EdgeInsets.only(
                top: 40,
                bottom: 5,
              ),
              child: _img(),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: 10,
              bottom: 2,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                _textnome(),
                _textemail(),
              ],
            ),
          ),
        ],
      ),
    );
  }
  _corpo() {
    return Container(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              screenPointer = 1;
              _onClickBody(context, screenPointer);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconAnuncios(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Anúncios"),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              screenPointer = 2;
              _onClickBody(context, screenPointer);
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconFavoritos(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Favoritos"),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              screenPointer = 3;
              _onClickBody(context, screenPointer);
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconReservas(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Reservas"),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              screenPointer = 4;
              _onClickBody(context, screenPointer);
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconHistorico(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Histórico"),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              screenPointer = 5;
              _onClickBody(context, screenPointer);
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconChat(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Chat"),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              screenPointer = 6;
              _onClickBody(context, screenPointer);
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconSuporte(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Suporte"),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              screenPointer = 7;
              _onClickBody(context, screenPointer);
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconDicas(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Dicas de Segurança"),
                  ),
                ),
              ],
            ),
          ),GestureDetector(
            onTap: () {
              screenPointer = 8;
              _onClickBody(context, screenPointer);
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconFAQ(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("FAQ"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

_text(String x) {
  return Text(
    x,
    style: TextStyle(
      color: Colors.black54,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );
}

_iconAnuncios(){
  return Icon(
    Icons.grid_on,
    color: Colors.black54,
    size: 20.0,
  );
}

_iconFavoritos(){
  return Icon(
    Icons.star,
    color: Colors.black54,
    size: 20.0,
  );
}

_iconReservas(){
  return Icon(
    Icons.playlist_add_check,
    color: Colors.black54,
    size: 20.0,
  );
}

_iconHistorico(){
  return Icon(
    Icons.history,
    color: Colors.black54,
    size: 20.0,
  );
}

_iconChat(){
  return Icon(
    Icons.question_answer,
    color: Colors.black54,
    size: 20.0,
  );
}

_iconSuporte(){
  return Icon(
    Icons.assistant,
    color: Colors.black54,
    size: 20.0,
  );
}

_iconDicas(){
  return Icon(
    Icons.warning,
    color: Colors.black54,
    size: 20.0,
  );
}

_iconFAQ(){
  return Icon(
    Icons.help_outline,
    color: Colors.black54,
    size: 20.0,
  );
}

void _onClickBody(context, int x) {

  if (x == 1) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaMain();
        },
      ),
    );
  } else if (x == 2) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaFavoritos();
        },
      ),
    );
  } else if (x == 3) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaReservas();
        },
      ),
    );
  } else if (x == 4) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaHistorico();
        },
      ),
    );
  } else if (x == 5) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaChat();
        },
      ),
    );
  } else if (x == 6) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaSuporte();
        },
      ),
    );
  } else if (x == 7) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaDicas();
        },
      ),
    );
  }
  else if (x == 8) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) {
          return TelaFAQ();
        },
      ),
    );
  }
}
