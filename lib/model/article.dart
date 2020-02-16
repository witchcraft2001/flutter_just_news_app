import 'package:just_news/model/source.dart';

class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  DateTime publishedAt;
  String content;

  Article(this.source, this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);

  Article.fromMappedJson(Map<String, dynamic> json)
      : source = Source.fromMappedJson(json['source']),
        author = json['author'],
        title = json['title'],
        description = json['description'],
        url = json['url'],
        urlToImage = json['urlToImage'],
        publishedAt = DateTime.parse(json['publishedAt']),
        content = json['content'];
}

class ArticlesList {
  List<Article> articlesList;

  ArticlesList(this.articlesList);

  ArticlesList.fromMappedJson(Map<String, dynamic> json) {
    var list = json['articles'] as List;
    articlesList = list.map((a) => Article.fromMappedJson(a)).toList();
  }
}
