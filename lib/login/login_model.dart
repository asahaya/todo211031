import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {

  final titleCon=TextEditingController();
  final authorCon=TextEditingController();

  String? email;
  String? password;

  void setEmail(String email){
    this.email=email;
    notifyListeners();
  }
  void setPassword(String password){
    this.password=password;
    notifyListeners();
  }

  Future signUp() async{
    this.email =titleCon.text;
    this.password=authorCon.text;

    //ログイン
  }

}
