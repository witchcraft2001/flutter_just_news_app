import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_news/model/article.dart';
import 'package:just_news/ui/screen/article_details/article_details.dart';

class ArticlesListWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArticlesListWidgetState();
  }
}

class ArticlesListWidgetState extends State {

  var articlesList = List<Article>();

  @override
  void initState() {
    parseArticleList().then((value) {
      setState(() {
        articlesList = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Just News'),
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(
        itemCount: articlesList != null ? articlesList.length : 0,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ArticleDetailsScreen(
                      title: articlesList[index].title,
                      posterUrl: articlesList[index].urlToImage,
                      content: articlesList[index].content,
                      index: index,
                    )),
              );
            },
            child: CustomListItem(
              urlToImage: articlesList[index].urlToImage,
              title: articlesList[index].title,
              index: index,
            ),
          );
        },
      ),
    );
  }

  Future<List<Article>> parseArticleList() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("res/assets/articles.json");
    Map<String, dynamic> decodedJson = jsonDecode(data);
    ArticlesList articlesList = ArticlesList.fromMappedJson(decodedJson);
    return articlesList.articlesList;
  }
}

class CustomListItem extends StatelessWidget {
  const CustomListItem({this.urlToImage, this.title, this.index});

  final String urlToImage;
  final String title;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Hero(
              tag: 'photo{$index}',
              child: Container(
                height: 60.0,
                width: 60.0,
                child: Image.network(
                  urlToImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                title,
                maxLines: 2,
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}