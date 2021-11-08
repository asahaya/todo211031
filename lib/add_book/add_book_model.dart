import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo211031/domain/book.dart';

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;
  File? imageFile;
  bool isLoading=false;

  final picker = ImagePicker();

  void startLoading(){
    isLoading=true;
    notifyListeners();
  }
  void endLoading(){
    isLoading=false;
    notifyListeners();
  }



  Future addBook() async {
    if (title == null || title == "") {
      throw "タイトルが空";
    }
    if (author == null || author!.isEmpty) {
      throw "著者が空";
    }

    final doc= FirebaseFirestore.instance.collection('books').doc();

    String? imageURL;
    if(imageFile!=null) {
      //Firestoreにアップする前にStorageにアップする
      final task = await FirebaseStorage.instance.ref('books/${doc.id}')
          .putFile(imageFile!);
      imageURL= await task.ref.getDownloadURL();
    }

    //firestoreに追加
    await doc.set({
      "title": title,
      "author": author,
      "imageURL":imageURL,
    });
  }

  Future pickImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      imageFile = File(pickerFile.path);
      notifyListeners();
    }
  }
}
