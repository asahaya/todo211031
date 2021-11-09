
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo211031/login/login_model.dart';
import 'package:todo211031/register/register_page.dart';



class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginModel>(
      create: (_) => LoginModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('ログイン'),
        ),
        body: Center(
          child: Consumer<LoginModel>(builder: (context, model, child) {
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
                          model.startLoading();
                          //画面遷移
                          try {
                            await model.login(); //追加の処理
                            Navigator.of(context).pop();
                          } catch (e) {
                            final snackbar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }finally{
                            model.endLoading();
                          }
                        },
                        child: Text("ログイン"),
                      ),
                      TextButton(
                        onPressed:()async {

                          //画面遷移
                          try {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                                fullscreenDialog: true, //下から遷移する
                              ),
                            );
                          } catch (e) {
                            final snackbar = SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(e.toString()));
                            ScaffoldMessenger.of(context).showSnackBar(snackbar);
                          }
                        },
                        child: Text("新規登録の方はこちら"),
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
