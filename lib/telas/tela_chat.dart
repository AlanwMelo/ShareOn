import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TelaChat extends StatefulWidget {
  @override
  _TelaChatState createState() => _TelaChatState();
}

class _TelaChatState extends State<TelaChat> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeChat(),
    );
  }
}

homeChat() {
  return Scaffold(
    body: Container(
      child: Center(
        child: Text("CHAT"),
      ),
    ),
  );
}
