import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo211031/domain/book.dart';

class EditBookModel extends ChangeNotifier {

  //情報の引き渡し
  final Book book;
  EditBookModel(this.book){
    titleCon.text=book.title;
    authorCon.text=book.author;
  }

  final titleCon=TextEditingController();
  final authorCon=TextEditingController();

  String? title;
  String? author;

  void setTitle(String title){
    this.title=title;
    notifyListeners();
  }
  void setAuthor(String author){
    this.author=author;
    notifyListeners();
  }

  bool isUpdated(){
    return title!= null || author != null;
  }

  Future updateBook() async{
  this.title =titleCon.text;
  this.author=authorCon.text;
    //firestoreに追加
    await FirebaseFirestore.instance.collection('books').doc(book.id).update({
      "title": title,
      "author": author,
    });
  }

}
