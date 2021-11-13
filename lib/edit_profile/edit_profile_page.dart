import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo211031/edit_book/edit_book_model.dart';
import 'package:todo211031/edit_profile/edit_profile_model.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage(this.name,this.description);

  final String name;
  final String description;


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EditProfileModel>(
      create: (_) => EditProfileModel(name,description),
      child: Scaffold(
        appBar: AppBar(
          title: Text('プロフィール編集'),
        ),
        body: Center(
          child: Consumer<EditProfileModel>(builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: model.nameCon,
                    decoration: InputDecoration(
                      hintText: "名前",
                    ),
                    onChanged: (text) {
                      //ここで取得したTextを使う
                      // model.title = text;
                      model.setName(text);
                    },
                  ),
                  TextField(
                    controller: model.descriptionCon,
                    decoration: InputDecoration(
                      hintText: "bio",
                    ),
                    onChanged: (text) {
                      //ここで取得したTextを使う
                      // model.author = text;
                      model.setDescription(text);
                    },
                  ),
                  ElevatedButton(
                    onPressed:model.isUpdated ()
                        ? ()async {
                      //画面遷移
                      try {
                        await model.updateBook(); //追加の処理
                        Navigator.of(context).pop();
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
