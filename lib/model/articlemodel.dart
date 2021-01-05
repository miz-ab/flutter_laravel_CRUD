class ArticleModel {
  int id;
  String title;
  String body;

  ArticleModel({this.id, this.title, this.body});

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }

  Map<String, dynamic> toJsonAdd() {
    return {
      "id": id,
      "title": title,
      "body": body,
    };
  }

  Map<String, dynamic> toJsonUpdate() {
    return {
      "id": id,
      "title": title,
      "body": body,
    };
  }
}
