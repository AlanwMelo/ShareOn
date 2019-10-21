import 'package:aplicativo_shareon/models/usuario_model.dart';
import 'package:aplicativo_shareon/telas/home.dart';
import 'package:aplicativo_shareon/telas/tela_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'tela_CadastroUsuario.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

  class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  final campos = GlobalKey<FormState>();
  final verificacao = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: verificacao,
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){

            if(model.carregando)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: campos,
              child: ListView(
                padding: EdgeInsets.fromLTRB(16, 200, 16, 200),
                children: <Widget>[
                  TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "E-mail",
                        icon: Icon(
                          Icons.mail,
                          color: Colors.indigo,
                        ),
                      ),
                      validator: (valor){
                        if(valor.isEmpty){
                          return "Campo Email obrigatório";
                        } else if(!valor.contains("@")) {
                          return "Digite um email válido";
                        } else {
                          return null;
                        }
                      }
                  ),
                  SizedBox(height: 16,),
                  TextFormField(
                    controller: passController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Senha",
                        icon: Icon(
                          Icons.lock,
                          color: Colors.indigo,
                        )
                    ),
                    validator: (valor){
                      if(valor.isEmpty){
                        return "Campo Senha obrigatório";
                      } else if (valor.length<6){
                        return "Senha curta, mínimo 6 digitos";
                      } else{
                        return null;
                      }
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: FlatButton(onPressed: (){
                      if(emailController.text.isEmpty)
                        verificacao.currentState.showSnackBar(
                            SnackBar(content: Text("Insira seu e-mail para recuperação"),
                              backgroundColor: Colors.redAccent,
                              duration: Duration(seconds: 2),
                            )
                        );
                      else {
                        model.recoverPass(emailController.text);
                        verificacao.currentState.showSnackBar(
                            SnackBar(content: Text("Um e-mail de confirmação foi enviado no seu endereço de e-mail."),
                              backgroundColor: Theme
                                  .of(context)
                                  .primaryColor,
                              duration: Duration(seconds: 2),
                            )
                        );
                      }
                    },
                      child: Text("Esqueci minha senha",
                        textAlign: TextAlign.right,
                      ),
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: 16,),
                  SizedBox(
                    height: 44,
                    child: RaisedButton(
                      child: Text("Entrar",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      onPressed: (){

                        if(campos.currentState.validate()){}

                        model.signIn(
                            email: emailController.text,
                            pass: passController.text,
                            onSuccess: _onSuccess,
                            onFail: _onFail
                        );
                      },
                    ),
                  ),
                  FlatButton(
                      padding: EdgeInsets.only(top: 12),

                      child: Text("Novo por aqui? Cadastre-se",
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.indigo
                        ),
                      ),
                      onPressed: (){
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context)=>CadastroUsuario())
                        );
                      }
                  )
                ],
              ),
            );
          },
        )
    );
  }

  void _onSuccess(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));

  }

  void _onFail(){
    verificacao.currentState.showSnackBar(
        SnackBar(content: Text("Falha ao entrar!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        )
    );
  }

}

