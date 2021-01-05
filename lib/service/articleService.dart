import 'dart:developer';
import 'dart:io';

import 'package:flutter_app_test/model/articlemodel.dart';
import 'dart:convert';
import "package:http/http.dart" as http;

class ArticleServies {
  static const IP = "192.168.137.124";
  static const ADD_ARTICLE_URL = "http://10.0.2.2:8000/api/articles";
  static const GET_ARTICLE_URL = "http://10.0.2.2:8000/api/articles";
  static const DELETE_ARTICLE_URL = "http://10.0.2.2:8000/api/articles/";
  static const UPDATE_ARTICLE_URL = "http://10.0.2.2:8000/api/articles/";

  Future<String> addArticle(ArticleModel articleModel) async {
    log('add data ' + articleModel.title.toString());

    //final response =await http.post(ADD_ARTICLE_URL, body: articleModel.toJsonAdd());
    final data = {"title": articleModel.title, "body": articleModel.body};
    final response = await http.post(ADD_ARTICLE_URL,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode(data));

    if (response.statusCode == 200) {
      print("res" + response.body);
      return response.body;
    } else {
      return "err";
    }
  }

  List<ArticleModel> articleFromJson(String jsonString) {
    final data = json.decode(jsonString);
    String dataa = json.decode(jsonString).toString();
    log('all json data ' + dataa);
    return List<ArticleModel>.from(
        data.map((item) => ArticleModel.fromJson(item)));
  }

  Future<List<ArticleModel>> getArticle() async {
    final response = await http.get(GET_ARTICLE_URL);
    if (response.statusCode == 200) {
      List<ArticleModel> articleList = articleFromJson(response.body);
      return articleList;
    } else {
      return List<ArticleModel>();
    }
  }

  //update article
  Future<String> updateArticle(ArticleModel articleModel) async {
    final dt = {'title': articleModel.title, 'body': articleModel.body};
    final response =
        await http.put(UPDATE_ARTICLE_URL + articleModel.id.toString(),
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
            },
            body: json.encode(dt));
    log("ressss" + response.body.toString());
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "err";
    }
  }

  //delete article
  Future<String> deleteArticle(ArticleModel articleModel) async {
    final response = await http
        .delete(DELETE_ARTICLE_URL + articleModel.id.toString(), headers: {
      HttpHeaders.contentTypeHeader: 'application/json',
    });
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "err";
    }
  }
} //end of class
