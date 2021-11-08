import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo211031/domain/book.dart';

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;

  File? imageFile;
  final picker = ImagePicker();

  Future addBook() async {
    if (title == null || title == "") {
      throw "タイトルが空";
    }
    if (author == null || author!.isEmpty) {
      throw "著者が空";
    }
    //firestoreに追加
    await FirebaseFirestore.instance.collection('books').add({
      "title": title,
      "author": author,
    });
  }

  Future pickImage() async {
    final pickerFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickerFile != null) {
      imageFile = File(pickerFile.path);
    }
  }
}
