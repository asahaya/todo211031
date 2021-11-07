import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo211031/add_book/add_book_model.dart';
import 'package:todo211031/book_list/book_list_model.dart';
import 'package:todo211031/domain/book.dart';
import 'package:todo211031/edit_book/edit_book_model.dart';

class EditBookPage extends StatelessWidget {
  //情報の引き渡し
  final Book book;
  EditBookPage(this.book);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditBookModel>(
      create: (_) => EditBookModel(book),
      child: Scaffold(
        appBar: AppBar(
          title: Text('編集する'),
        ),
        body: Center(
          child: Consumer<EditBookModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.titleCon,
                    decoration: InputDecoration(
                      hintText: "本のタイトル",
                    ),
                    onChanged: (text) {
                      //ここで取得したTextを使う
                      // model.title = text;
                      model.setTitle(text);
                    },
                  ),
                  TextField(
                    controller: model.authorCon,
                    decoration: InputDecoration(
                      hintText: "本の著者",
                    ),
                    onChanged: (text) {
                      //ここで取得したTextを使う
                      // model.author = text;
                      model.setAuthor(text);
                    },
                  ),
                  ElevatedButton(
                    onPressed:model.isUpdated ()
                        ? ()async {
                      //画面遷移
                      try {
                        await model.updateBook(); //追加の処理
                        Navigator.of(context).pop(model.title);
                      } catch (e) {
                        final snackbar = SnackBar(
                            backgroundColor: Colors.red,
                            content: Text(e.toString()));
                        ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      }
                    }
                    :null,
                    child: Text("更新する"),
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
