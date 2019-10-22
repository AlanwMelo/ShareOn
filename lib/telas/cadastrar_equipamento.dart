import 'package:aplicativo_shareon/utils/product_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {

  final ProductBloc _productBloc;


  ProductScreen() : _productBloc = ProductBloc();

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {

    final _fieldStyle = TextStyle(
      color: Colors.black,
      fontSize: 16
    );

    InputDecoration _buildDecoration(String label){
      return InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black)
      );
    }


    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastrar Equipamento"),
      ),
      body: Form(
        child: ListView(
          padding: EdgeInsets.all(16),
          children: <Widget>[
            TextFormField(
              style: _fieldStyle,
              decoration: _buildDecoration("Titulo"),
              onSaved: (t){},
              validator: (t){},
            ),
            TextFormField(
              maxLines: 6,
              style: _fieldStyle,
              decoration: _buildDecoration("Descrição"),
              onSaved: (t){},
              validator: (t){},
            ),
            TextFormField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              style: _fieldStyle,
              decoration: _buildDecoration("Preço"),
              onSaved: (t){},
              validator: (t){},
            ),
          ],
        ),
      ),
    );
  }
}
