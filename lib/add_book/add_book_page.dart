import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo211031/add_book/add_book_model.dart';
import 'package:todo211031/book_list/book_list_model.dart';
import 'package:todo211031/domain/book.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Center(
          child: Consumer<AddBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    decoration: InputDecoration(
                      hintText: "本のタイトル",
                    ),
                    onChanged: (text) {
                      //ここで取得したTextを使う
                      model.title = text;
                    },
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "本の著者",
                    ),
                    onChanged: (text) {
                      //ここで取得したTextを使う
                      model.author = text;
                    },
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      //画面遷移
                      try {
                        await model.addBook(); //追加の処理
                        Navigator.of(context).pop(true);
                      } catch (e) {
                        final snackbar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    },
                    child: Text("追加する"),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
