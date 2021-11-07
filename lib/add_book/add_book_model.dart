import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo211031/domain/book.dart';

class AddBookModel extends ChangeNotifier {

  String? title;
  String? author;

  Future addBook() async{
    if(title==null || title==""){
      throw "タイトルが空";
    }
    if(author==null || author!.isEmpty){
      throw "著者が空";
    }
    //firestoreに追加
   await FirebaseFirestore.instance.collection('books').add({
       "title": title,
      "author": author,
      });
  }

}
