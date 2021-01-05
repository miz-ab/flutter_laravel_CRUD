import 'package:flutter/material.dart';
import 'package:flutter_app_test/service/articleService.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:toast/toast.dart';

import 'model/articlemodel.dart';

class AddArticle extends StatefulWidget {
  //final ArticleModel articleModel;
  //final int index;

  //AddEditArticle();
  //AddEditArticle(this.articleModel, this.index);

  @override
  AddEditArticleState createState() => AddEditArticleState();
}

class AddEditArticleState extends State<AddArticle> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  add(ArticleModel articleModel) async {
    await ArticleServies().addArticle(articleModel).then((success) {
      Fluttertoast.showToast(
          msg: "Article Added Successfuly",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.black,
          fontSize: 16.0);
      Navigator.pop(context);
    });
  }

  /*
  update(ArticleModel articleModel) async {
    await ArticleServies().updateArticle(articleModel).then((success) {
      Fluttertoast.showToast(
          msg: "Article Updated Successfuly",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIos: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.black,
          fontSize: 16.0);

      Navigator.pop(context);
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Article'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: title,
              decoration: InputDecoration(hintText: 'Enter Title'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: body,
              decoration: InputDecoration(hintText: 'Enter Body'),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: RaisedButton(
              onPressed: () {
                if (title.text.isEmpty) {
                  //Toast.show("msg", context, gravirt: Toast.CENTER,duration:2);
                  Fluttertoast.showToast(
                      msg: "Enter Article ",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIos: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.black,
                      fontSize: 16.0);
                } else {
                  ArticleModel articleModel =
                      ArticleModel(title: title.text, body: body.text);
                  add(articleModel);
                }
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
