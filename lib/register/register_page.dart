
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo211031/register/register_model.dart';


class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterModel>(
      create: (_) => RegisterModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
        ),
        body: Center(
          child: Consumer<RegisterModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: model.titleCon,
                        decoration: InputDecoration(
                          hintText: "Email",
                        ),
                        onChanged: (text) {
                          //ここで取得したTextを使う
                          // model.title = text;
                          model.setEmail(text);
                        },
                      ),
                      TextField(
                        controller: model.authorCon,
                        decoration: InputDecoration(
                          hintText: "Password",
                        ),
                        onChanged: (text) {
                          //ここで取得したTextを使う
                          // model.author = text;
                          model.setPassword(text);
                        },
                      ),
                      ElevatedButton(
                        onPressed:()async {
                          //画面遷移
                          try {
                            await model.signUp(); //追加の処理
                            Navigator.of(context).pop;
                          } catch (e) {
                            print("-------------->$e");
                            final snackbar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }finally{
                            model.endLoading();
                          }
                        },
                        child: Text("新規作成する"),
                      ),
                    ],
                  ),
                ),
                if(model.isLoading)
                  Container(
                    color: Colors.black54,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
