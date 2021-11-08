import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo211031/domain/book.dart';

class RegisterModel extends ChangeNotifier {

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

    //Firebase Authでユーザー作成



    //firestoreに追加
    // await FirebaseFirestore.instance.collection('books').doc(book.id).update({
    //   "title": title,
    //   "author": author,
    // });
  }

}
