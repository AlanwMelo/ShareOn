import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Texts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

textTitulo(String titulo) {
  return Text(
    titulo,
    style: TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Colors.black45,
    ),
  );
}