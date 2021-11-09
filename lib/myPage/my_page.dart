import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo211031/myPage/my_model.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MyModel>(
      create: (_) => MyModel()..fetchUser(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('マイページ'),
        ),
        body: Center(
          child: Consumer<MyModel>(builder: (context, model, child) {
            return Stack(
              children: [
                Column(
                  children:  [
                    Text("名前"),
                    Text(model.email ?? "emailなし"),
                    Text("自己紹介"),
                  ],
                ),
                if (model.isLoading)
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
