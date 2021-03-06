import 'package:aplicativo_shareon/telas/editar_perfil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MeuPerfil extends StatefulWidget {
  @override
  _MeuPerfilState createState() => _MeuPerfilState();
}

class _AvaliacoesHist {
  String description;
  Timestamp ts;

  _AvaliacoesHist(this.description, this.ts);
}

class _MeuPerfilState extends State<MeuPerfil> {
  SharedPreferencesController sharedPreferencesController =
      new SharedPreferencesController();
  final databaseReference = Firestore.instance;

  String userName = "";
  String userMail = "";
  String userPhone = "";
  String userimgURL;
  String userAddress = "";
  String userMedia = "0.0";
  String userID = "";
  List<_AvaliacoesHist> avaliacoes = [];

  @override
  void initState() {
    sharedPreferencesController.getName().then(_setUserName);
    sharedPreferencesController.getEmail().then(_setUserMail);
    sharedPreferencesController.getURLImg().then(_setURLImg);
    sharedPreferencesController.getAddress().then(_setAddress);
    sharedPreferencesController.getID().then(_setId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _meuPerfil();
  }

  Widget _meuPerfil() {
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
          title: Text('Perfil'),
          elevation: 0,
          backgroundColor: Colors.indigoAccent,
          actions: <Widget>[
            Expanded(
              child: Container(),
            ),
            Expanded(
              child: Container(
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return EditarPerfil();
                      }));
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Center(
                    child: GestureDetector(
                  onTap: () {
                    alertExit(context);
                  },
                  child: Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'RobotoMono',
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ),
            ),
          ]),
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  _img(),
                  Container(
                      margin: EdgeInsets.only(top: 16),
                      child: _text(userName, titulo: true)),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: _text(userMail),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _text(userMedia),
                        _iconEstrela(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8),
                    child: _text("Endereço: ", semititle: true),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 12, bottom: 4),
                    child: _text(userAddress),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 4),
                    child: _text("Telefone:", semititle: true),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 8, bottom: 4),
                    child: _text(userPhone),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 24),
                    child: _text("Avaliações:", semititle: true),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 40,
                    ),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.white,
                          child: avaliacoes.length == 0
                              ? Center(
                                  child: _text(
                                      "Você ainda não possui avaliações.",
                                      resumo: true),
                                )
                              : _avaliacoesList(),
                        ),
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

  void _setURLImg(String urlImg) {
    setState(() {
      userimgURL = urlImg;
    });
  }

  void _logout(BuildContext context) {
    FirebaseAuth.instance.signOut();
    SharedPreferencesController sharedPreferencesController =
        new SharedPreferencesController();
    sharedPreferencesController.setlogedState("0");
    sharedPreferencesController.setID("");
    sharedPreferencesController.setName("");
    sharedPreferencesController.setEmail("");
    sharedPreferencesController.setEmailAuth(false);
    sharedPreferencesController.setURLImg("");
    sharedPreferencesController.setAddress("");
    _succesLogout();
  }

  void _succesLogout() {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
      (Route<dynamic> route) => false,
    );
  }

  _img() {
    return GestureDetector(
      child: Container(
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
              color: Colors.white,
              child: userimgURL == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Image.network(
                      userimgURL,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
      ),
    );
  }

  _text(String texto,
      {bool titulo = false, bool resumo = false, bool semititle = false}) {
    if (titulo == true) {
      return Text(
        "$texto",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 30,
        ),
      );
    } else if (resumo == true) {
      return Text(
        "$texto",
        style: TextStyle(fontSize: 16, color: Colors.black),
      );
    } else if (semititle == true) {
      return Text(
        texto,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 26,
        ),
      );
    } else {
      return Text(
        "$texto",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 19,
        ),
      );
    }
  }

  _iconEstrela() {
    return Icon(
      Icons.star,
      color: Colors.white,
      size: 20.0,
    );
  }

  _setAddress(String value) {
    setState(() {
      userAddress = value;
    });
  }

  _getUserData() async {
    await databaseReference
        .collection("users")
        .where("userID", isEqualTo: userID)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        Map userData = f.data;
        setState(() {
          userMedia = userData["media"];
          userAddress = userData["userAddress"];
          userPhone = userData["tel_contato"];
        });
      });
    });
  }

  _setId(String value) {
    setState(() {
      userID = value;
      _getUserData();
      _getList();
    });
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
                    height: 135,
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
                                color: Colors.red,
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Text(
                            "Deseja mesmo desconectar-se da sua conta?",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.none,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              color: Colors.indigoAccent,
                              margin: EdgeInsets.only(
                                top: 8,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      height: 100,
                                      child: RaisedButton(
                                        color: Colors.indigoAccent,
                                        onPressed: () {
                                          setState(() {
                                            Navigator.pop(context);
                                            _logout(context);
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
                                        color: Colors.indigoAccent,
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Cancelar",
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

  _getList() async {
    await databaseReference
        .collection("scoreValues")
        .where("ID", isEqualTo: userID)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        Map values = f.data;
        if (values["description"] != null) {
          Timestamp auxTS =
              values["statusTS"] ?? Timestamp.fromDate(DateTime.now());
          setState(() {
            avaliacoes.add(new _AvaliacoesHist(values["description"], auxTS));
            avaliacoes.sort((a, b) => b.ts.compareTo(a.ts));
          });
        }
      });
    });
  }

  _avaliacoesList() {
    return Center(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: avaliacoes.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                margin: EdgeInsets.only(left: 8, right: 8),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _avaliacoesText(avaliacoes[index].description),
                      ],
                    ),
                    Divider(thickness: 2),
                  ],
                ));
          }),
    );
  }

  _avaliacoesText(String text) {
    return Text(
      "$text",
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black54,
        fontSize: 16,
      ),
    );
  }
}
