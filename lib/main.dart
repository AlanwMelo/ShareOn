import 'package:aplicativo_shareon/telas/tela_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'models/usuario_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main (){

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel <UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: "Share On",
        theme: ThemeData(
            primaryColor: Color.fromARGB(255, 3, 50, 92)
        ),
        debugShowCheckedModeBanner: false,
        home: Login(),
      ),
    );
  }
}

