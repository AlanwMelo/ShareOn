import 'dart:async';
import 'package:aplicativo_shareon/models/usuario_model.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CadastroUsuario extends StatefulWidget {
  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {

  final nomeController = TextEditingController();
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final enderecoController = TextEditingController();

  final campos = GlobalKey<FormState>();
  final verificacao = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: verificacao,
        appBar: AppBar(
          title: Text("Criar Conta"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){
            if(model.carregando)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: campos,
              child: ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  TextFormField(
                    controller: nomeController,
                    decoration: InputDecoration(
                        hintText: "Nome Completo"
                    ),
                    validator: (text){
                      if(text.isEmpty){
                        return "Campo Nome Completo obrigatório";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "E-mail"
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (text){
                      if(text.isEmpty){
                        return "Campo Email obrigatório";
                      } else if(!text.contains("@")) {
                        return "Digite um email válido";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: senhaController,
                    decoration: InputDecoration(
                        hintText: "Senha"
                    ),
                    obscureText: true,
                    validator: (text){
                      if(text.isEmpty){
                        return "Campo Senha obrigatório";
                      } else if (text.length<6){
                        return "Senha curta, mínimo 6 digitos";
                      } else{
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16.0,),
                  TextFormField(
                    controller: enderecoController,
                    decoration: InputDecoration(
                        hintText: "Endereço"
                    ),
                    validator: (text){
                      if(text.isEmpty){
                        return "Campo Endereço obrigatório";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 16.0,),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      child: Text("Criar Conta",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){
                        if(campos.currentState.validate()){

                          Map<String, dynamic> userData = {
                            "nome": nomeController.text,
                            "email": emailController.text,
                            "endereco": enderecoController.text
                          };

                          model.signUp(
                              userData: userData,
                              pass: senhaController.text,
                              onSuccess: sucesso,
                              onFail: falha
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  void sucesso(){
    verificacao.currentState.showSnackBar(
        SnackBar(content: Text("Usuário criado com sucesso!"),
          backgroundColor: Theme.of(context).primaryColor,
          duration: Duration(seconds: 2),
        )
    );
    Future.delayed(Duration(seconds: 2)).then((_){
      Navigator.of(context).pop();
    });
  }

  void falha(){
    verificacao.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao criar usuário!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}

