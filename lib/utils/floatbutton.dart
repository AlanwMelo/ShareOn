import 'package:aplicativo_shareon/telas/cadastrar_equipamento.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ProductScreen())
          );
        },
        child: Container(
          width: 160,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.indigo,
                borderRadius: BorderRadius.circular(40)
          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.camera_alt, color: Colors.white,),
            SizedBox(width: 7,),
            Text("Anuncie Aqui!", style: TextStyle(color: Colors.white),)
          ],
        ),
        ),
      ),
    );
  }
}
