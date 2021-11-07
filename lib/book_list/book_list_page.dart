import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo211031/add_book/add_book_page.dart';
import 'package:todo211031/book_list/book_list_model.dart';
import 'package:todo211031/domain/book.dart';
import 'package:todo211031/edit_book/edit_book_page.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBookList(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('本一覧'),
        ),
        body: Center(
          child: Consumer<BookListModel>(builder: (context, model, child) {
            final List<Book>? books = model.books;

            if (books == null) {
              return CircularProgressIndicator();
            }

            final List<Widget> widgets = books
                .map(
                  (book) => Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    child: ListTile(
                      title: Text(book.title),
                      subtitle: Text(book.author),
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: 'edit',
                        color: Colors.black45,
                        icon: Icons.edit,
                        onTap: () async{
                          final String? title = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditBookPage(book),
                              // fullscreenDialog: false, //下から遷移する
                            ),
                          );
                          if (title != null) {
                            final snackbar = SnackBar(
                                backgroundColor: Colors.grey,
                                content: Text("$titleを編集しました"));
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                          model.fetchBookList();
                        },
                      ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: ()async{
                          await showConfirmDialog(context, book,model);
                        },
                      ),
                    ],
                  ),
                )
                .toList();
            return ListView(
              children: widgets,
            );
          }),
        ),
        floatingActionButton:
            Consumer<BookListModel>(builder: (context, model, child) {
          return FloatingActionButton(
            onPressed: () async {
              final bool? added = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddBookPage(),
                  fullscreenDialog: true, //下から遷移する
                ),
              );
              if (added != null && added) {
                final snackbar = SnackBar(
                    backgroundColor: Colors.greenAccent,
                    content: Text("本を追加しました"));
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              }
              model.fetchBookList();
            },
            tooltip: 'Increment',
            child: Icon(Icons.add),
          );
        }),
      ),
    );
  }

  Future showConfirmDialog(BuildContext context, Book book,BookListModel model){
   return showDialog(
      context:context,
      // barrierDismissible: false,
     builder: (_){
        return AlertDialog(
          title: Text("削除の確認"),
          content: Text("${book.title}を削除しますか？"),
          actions: [
            TextButton(
              child: Text("No"),
              onPressed: ()=>Navigator.pop(context),
            ),
            TextButton(
              child: Text("Yes"),
              onPressed: ()async{
                //modelで削除
                await model.deleteBook(book);
                final snackbar = SnackBar(
                    backgroundColor: Colors.red,
                    content: Text("${book.title}を削除しました"));
                model.fetchBookList();
                ScaffoldMessenger.of(context).showSnackBar(snackbar);
              },
            ),
          ],
        );
     }
    );
  }
}
