import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo211031/domain/book.dart';

class EditProfileModel extends ChangeNotifier {

  EditProfileModel(this.name,this.description){
    nameCon.text=name! ;
    descriptionCon.text=description!;
  }

  final nameCon=TextEditingController();
  final descriptionCon=TextEditingController();

  String? name;
  String? description;

  void setName(String name){
    this.name=name;
    notifyListeners();
  }
  void setDescription(String description){
    this.description=description;
    notifyListeners();
  }

  bool isUpdated(){
    return name!= null || description != null;
  }

  Future updateBook() async{
    this.name =nameCon.text;
    this.description=descriptionCon.text;
    //firestoreに追加
    final uid=FirebaseAuth.instance.currentUser!.uid; //ここにきてる時点でログインしてるのでOK
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      "name": name,
      "description": description,
    });
  }


}
