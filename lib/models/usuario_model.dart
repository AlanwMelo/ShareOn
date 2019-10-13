import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';

class UserModel extends Model{

  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseUser firebaseUser;
  Map<String, dynamic> userData = Map();

  bool carregando = false;

  //usuario atual

  void signUp({@required Map<String, dynamic> userData, @required String pass,
    @required VoidCallback onSuccess, @required VoidCallback onFail}){

    carregando = true;
    notifyListeners();

    auth.createUserWithEmailAndPassword(
        email: userData["email"],
        password: pass
    ).then((user) async {
      firebaseUser = user;

      await saveUserData(userData);

      onSuccess();
      carregando = false;
      notifyListeners();
    }).catchError((e){
      onFail();
      carregando = false;
      notifyListeners();
    });

  }

  void signIn() async{
    carregando = true;
    notifyListeners();

    await Future.delayed(Duration(seconds: 3));

    carregando = false;
    notifyListeners();
  }

  void recoverPass(){}

  bool isLoggedIn(){
    return firebaseUser != null;
  }

  Future<Null> saveUserData(Map<String, dynamic> userData) async {
    this.userData = userData;
    await Firestore.instance.collection("usuarios").document(firebaseUser.uid).setData(userData);
  }

}