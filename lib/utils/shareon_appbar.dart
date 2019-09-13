import 'package:flutter/material.dart';

class ShareOnAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


shareon_appbar() {
  return AppBar(
    title: Text("Share On"),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.more_vert),
        onPressed: () {
          print("Icone");
        },
      )
    ],
  );
}
