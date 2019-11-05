import 'dart:async';
import 'dart:io';

import 'package:aplicativo_shareon/models/usuario_model.dart';
import 'package:aplicativo_shareon/telas/tela_chat.dart';
import 'package:aplicativo_shareon/telas/tela_configuracoes.dart';
import 'package:aplicativo_shareon/telas/tela_dicas.dart';
import 'package:aplicativo_shareon/telas/tela_faq.dart';
import 'package:aplicativo_shareon/telas/tela_favoritos.dart';
import 'package:aplicativo_shareon/telas/tela_historico.dart';
import 'package:aplicativo_shareon/telas/tela_main.dart';
import 'package:aplicativo_shareon/telas/tela_meus_produtos.dart';
import 'package:aplicativo_shareon/telas/tela_reservas.dart';
import 'package:aplicativo_shareon/telas/tela_suporte.dart';
import 'package:aplicativo_shareon/utils/floatbutton.dart';
import 'package:aplicativo_shareon/utils/shareon_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../main.dart';
import 'meu_perfil.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int controllerPointer = 1;
  String userName = "?";
  String userMail = "?";
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  void initState() {
    // TODO: implement initState
    SharedPreferencesController sharedPreferencesController =
        new SharedPreferencesController();

    sharedPreferencesController.getlogedState().then(_logedVerifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _Drawer(),
      key: _drawerKey,
      appBar: shareon_appbar(context),
      body: homeController(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _FloatActionButtonController(controllerPointer),
    );
  }

  homeController() {
    return WillPopScope(
      onWillPop: () async {
        if (_drawerKey.currentState.isDrawerOpen) {
          Navigator.pop(context);
        } else if (controllerPointer != 1) {
          setState(() {
            controllerPointer = 1;
          });
        } else if (controllerPointer == 1) {
          return alertExit(context);
        }
        return homeController1();
      },
      child: homeController1(),
    );
  }

  homeController1() {
    if (controllerPointer == 1) {
      return homeMain(context);
    } else if (controllerPointer == 2) {
      return homeFavoritos();
    } else if (controllerPointer == 3) {
      return homeReservas();
    } else if (controllerPointer == 4) {
      return homeHistorico();
    } else if (controllerPointer == 5) {
      return homeMeusProdutos();
    } else if (controllerPointer == 6) {
      return homeChat();
    } else if (controllerPointer == 7) {
      return homeSuporte();
    } else if (controllerPointer == 8) {
      return homeDicas();
    } else if (controllerPointer == 9) {
      return homeConfigurcoes();
    } else if (controllerPointer == 10) {
      return homeFAQ();
    }
  }

  _FloatActionButtonController(int controller) {
    if (controller == 1) {
      return FloatButton();
    } else {
      return Container();
    }
  }

  _Drawer() {
    return Drawer(
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _cabecalho(context),
              Container(
                child: Column(
                  children: <Widget>[
                    _corpo(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  alertExit(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            color: Colors.white.withOpacity(0.1),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: GestureDetector(
                  onTap: () => null,
                  child: Container(
                    color: Colors.white,
                    height: 120,
                    width: 300,
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 8, top: 8),
                            child: Text(
                              "Sair",
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Text(
                            "Deseja mesmo sair do app?",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.indigo,
                              margin: EdgeInsets.only(
                                top: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      child: RaisedButton(
                                        color: Colors.indigo,
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pop(context);
                                            exit(0);
                                          });
                                        },
                                        child: Text(
                                          "Sair",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      child: RaisedButton(
                                        color: Colors.indigo,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "voltar",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  _corpo() {
    return Container(
      height: 550,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
                controllerPointer = 1;
              });
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
              setState(() {
                Navigator.pop(context);
                controllerPointer = 2;
              });
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
              setState(() {
                Navigator.pop(context);
                controllerPointer = 3;
              });
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
              setState(() {
                Navigator.pop(context);
                controllerPointer = 4;
              });
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
              setState(() {
                Navigator.pop(context);
                controllerPointer = 5;
              });
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconMeusProdutos(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Meus Produtos"),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
                controllerPointer = 6;
              });
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
              setState(() {
                Navigator.pop(context);
                controllerPointer = 7;
              });
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
              setState(() {
                Navigator.pop(context);
                controllerPointer = 8;
              });
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
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
                controllerPointer = 9;
              });
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconConfig(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Configurações"),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
                controllerPointer = 10;
              });
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
          GestureDetector(
            onTap: () {
              setState(() {
                Navigator.pop(context);
                alertExit(context);
              });
            },
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(
                    left: 10,
                  ),
                  child: _iconExit(),
                ),
                SizedBox(
                  width: 270,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: 15,
                    ),
                    child: _text("Sair"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _setUserName(String name) {
    setState(() {
      userName = name;
    });
  }

  void _setUserMail(String email) {
    setState(() {
      userMail = email;
    });
  }

  _img() {
    return ClipRRect(
      borderRadius: BorderRadius.all(
        Radius.circular(180),
      ),
      child: Container(
        child: Image.network(
          "https://cdn4.iconfinder.com/data/icons/instagram-ui-twotone/48/Paul-18-512.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  _textnome() {
    return Text(
      userName,
      style: TextStyle(
        color: Colors.white,
        fontSize: 25,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _textemail() {
    return Text(
      userMail,
      style: TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.normal,
      ),
    );
  }

  _cabecalho(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        _onClick(context);
      },
      child: Container(
        color: Colors.indigo,
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
      ),
    );
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

  _iconAnuncios() {
    return Icon(
      Icons.grid_on,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconFavoritos() {
    return Icon(
      Icons.star,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconReservas() {
    return Icon(
      Icons.playlist_add_check,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconHistorico() {
    return Icon(
      Icons.history,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconMeusProdutos() {
    return Icon(
      Icons.assignment,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconChat() {
    return Icon(
      Icons.question_answer,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconSuporte() {
    return Icon(
      Icons.assistant,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconDicas() {
    return Icon(
      Icons.warning,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconFAQ() {
    return Icon(
      Icons.help_outline,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconConfig() {
    return Icon(
      Icons.settings,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _iconExit() {
    return Icon(
      Icons.exit_to_app,
      color: Colors.black54,
      size: 20.0,
    );
  }

  _onClick(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
      return MeuPerfil();
    }));
  }

  void _logedVerifier(String value) {
    if (value == "0"){
      setState(() {
        SharedPreferencesController sharedPreferencesController =
        new SharedPreferencesController();
        sharedPreferencesController.setlogedState("1");
      });
    }
  }
}
