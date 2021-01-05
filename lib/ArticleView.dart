import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app_test/model/articlemodel.dart';
import 'package:flutter_app_test/service/articleService.dart';
import 'package:flutter_app_test/EditArticle.dart';
import 'package:flutter_app_test/AddArticle.dart';
import 'package:fluttertoast/fluttertoast.dart';
import "package:http/http.dart" as http;
//import 'package:fluttertoast/fluttertoast.dart';
import 'EditArticle.dart';

class ArticleView extends StatefulWidget {
  @override
  ArticleViewState createState() => ArticleViewState();
}

class ArticleViewState extends State<ArticleView> {
  static const DELETE_ARTICLE_URL = "http://10.0.2.2:8000/api/articles/";
  List<ArticleModel> articleList;
  bool loading = true;

  getAllArticleList() async {
    articleList = await ArticleServies().getArticle();
    setState(() {
      loading = false;
      log('dataaaa');
    });
    articleList.forEach((element) {
      log('article list ' + element.id.toString());
    });
    //log('article list  + ${articleList.}');
  }

  @override
  void initState() {
    super.initState();
    log('dataaaa');
    getAllArticleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Article CRUD'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                //add new article
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddArticle(),
                  ),
                ).then((value) => getAllArticleList());
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: articleList.length,
                itemBuilder: (context, index) {
                  ArticleModel articleModel = articleList[index];
                  return ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      child: Text(articleModel.title[0]),
                    ),
                    title: Text(articleModel.title),
                    subtitle: Text(articleModel.body),
                    trailing: Wrap(
                      spacing: 3,
                      children: <Widget>[
                        IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue.shade400),
                            onPressed: () {
                              //btn edit pressed
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      EditArticle(articleModel, index),
                                ),
                              ).then((value) => getAllArticleList());
                            }),
                        IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () async {
                              //delete article

                              final response = await http.delete(
                                  DELETE_ARTICLE_URL +
                                      articleModel.id.toString(),
                                  headers: {
                                    HttpHeaders.contentTypeHeader:
                                        'application/json',
                                  });
                              if (response.statusCode == 200) {
                                Fluttertoast.showToast(
                                    msg: "Article Deleted Successfuly",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIos: 1,
                                    backgroundColor: Colors.blue,
                                    textColor: Colors.black,
                                    fontSize: 16.0);
                                return response.body;
                              } else {
                                return "err";
                              }
                            })
                      ],
                    ),
                  );
                },
              ));
  }
}
