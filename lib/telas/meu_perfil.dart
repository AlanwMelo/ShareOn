import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class MeuPerfil extends StatefulWidget {
  @override
  _MeuPerfilState createState() => _MeuPerfilState();
}

class _MeuPerfilState extends State<MeuPerfil> {
  SharedPreferencesController sharedPreferencesController =
  new SharedPreferencesController();

  String userName = "?";
  String userMail = "?";
  String userimgURL;

  @override
  void initState() {
    sharedPreferencesController.getName().then(_setUserName);
    sharedPreferencesController.getEmail().then(_setUserMail);
    sharedPreferencesController.getURLImg().then(_setURLImg);
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {},
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {},
            )
          ]
      ),
      body: SizedBox.expand(
        child: Container(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              _iconEditar(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  _img(),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    child: _text(userName, titulo: true),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16),
                    width: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _text("5.0"),
                        _iconEstrela(),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16, bottom: 24),
                    child: _text("Avaliações:"),
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: 40,
                      minWidth: 1000,
                    ),
                    child: Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          color: Colors.white,
                          child: _text("Você ainda não possui avaliações.",
                              resumo: true),
                        ),
                      ),
                    ),
                  ),
                  new Container(
                      width: 200.0,
                      height: 50.0,
                      margin: const EdgeInsets.all(95.0),
                      child: new RaisedButton(
                        child: new Text('Logout'),
                        onPressed: () {
                          _logout(context);
                        },
                        textColor: Colors.white70,
                        color: Colors.indigoAccent,
                      )),
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
            color: Colors.white,
            child: userimgURL == null ? Center(child: CircularProgressIndicator(),) : Image.network(
              userimgURL,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  _text(String texto, {bool titulo = false, bool resumo = false}) {
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
        style: TextStyle(
          fontSize: 16,
        ),
      );
    } else {
      return Text(
        "$texto",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 20,
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

  _iconEditar() {
    return Icon(
      Icons.edit,
      color: Colors.white,
      size: 25.0,
    );
  }
}
