import 'package:aplicativo_shareon/models/usuario_model.dart';
import 'package:aplicativo_shareon/telas/tela_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'tela_CadastroUsuario.dart';



class Login extends StatelessWidget {

  final formulario = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Entrar"),
          centerTitle: true,
        ),
        body: ScopedModelDescendant<UserModel>(
          builder: (context, child, model){

            if(model.isLoading)
              return Center(child: CircularProgressIndicator(),);

            return Form(
              key: formulario,
              child: ListView(
                padding: EdgeInsets.fromLTRB(16, 200, 16, 200),
                children: <Widget>[
                  TextFormField(
                      maxLines: 1,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "E-mail",
                        icon: Icon(
                          Icons.mail,
                          color: Color.fromARGB(255, 3, 50, 92),
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
                    maxLines: 1,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Senha",
                        icon: Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 3, 50, 92),
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
                    child: FlatButton(onPressed: (){},
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

                        model.signIn();


                        if(formulario.currentState.validate()){

                        }

                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context)=>TelaMain())
                        );
                      },
                    ),
                  ),
                  FlatButton(
                      padding: EdgeInsets.only(top: 12),

                      child: Text("Novo por aqui? Cadastre-se",
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 3, 50, 92)
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
}
