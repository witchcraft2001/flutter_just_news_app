import 'dart:convert';

import 'package:just_news/model/article.dart';
import 'package:http/http.dart' as http;

import 'configurations.dart';

class ArticleRepository {
  final String apiUrl = "http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$newsApiKey";
  http.Client client;

  Future<List<Article>> fetchArticles() async {
    var response = await client.get(apiUrl);
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = jsonDecode(response.body);
      ArticlesList articlesList = ArticlesList.fromMappedJson(decodedJson);
      return articlesList.articlesList;
    }
    throw Exception("Error code = ${response.statusCode}");
  }

  ArticleRepository() {
    client = http.Client();
  }
}