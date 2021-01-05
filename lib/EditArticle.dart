import 'package:flutter/material.dart';
import 'package:flutter_app_test/service/articleService.dart';
import 'package:fluttertoast/fluttertoast.dart';
//import 'package:toast/toast.dart';

import 'model/articlemodel.dart';

class EditArticle extends StatefulWidget {
  final ArticleModel articleModel;
  final int index;

  //AddEditArticle();
  EditArticle(this.articleModel, this.index);

  @override
  EditArticleState createState() => EditArticleState();
}

class EditArticleState extends State<EditArticle> {
  TextEditingController title = TextEditingController();
  TextEditingController body = TextEditingController();

  bool editMode = false;

  /*
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
  */

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

  @override
  void initState() {
    super.initState();
    if (widget.index != null) {
      title.text = widget.articleModel.title;
      body.text = widget.articleModel.body;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Article'),
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
                  //ArticleModel articleModel = ArticleModel(title: title.text, body: body.text);
                  //add(articleModel);
                  //String id_ = (widget.articleModel.id).toString();
                  ArticleModel articleModel = ArticleModel(
                      id: widget.articleModel.id,
                      title: title.text,
                      body: body.text);

                  update(articleModel);
                }
              },
              child: Text('Update'),
            ),
          ),
        ],
      ),
    );
  }
}
