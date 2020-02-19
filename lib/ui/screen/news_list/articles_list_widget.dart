import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:just_news/model/article.dart';
import 'package:just_news/model/country.dart';
import 'package:just_news/repository/article_repository.dart';
import 'package:just_news/ui/screen/article_details/article_details_widget.dart';

class ArticlesListScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ArticlesListScreenWidgetState();
  }
}

class ArticlesListScreenWidgetState extends State {

  var articlesList = List<Article>();
  var repository = ArticleRepository();

  @override
  void initState() {

    //todo: add country list loading
    repository.fetchArticles().then((value) {
      setState(() {
        articlesList = value;
      });
    }).catchError((error) {
      print(error);
    });
    super.initState();
  }

  Future<List<Country>> parseCountriesList() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("res/assets/countries.json");
    Map<String, dynamic> decodedJson = jsonDecode(data);
    CountryList countriesList = CountryList.fromMappedJson(decodedJson);
    return countriesList.countriesList;
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
                    builder: (context) => ArticleDetailsScreenWidget(
                      title: articlesList[index].title,
                      posterUrl: articlesList[index].urlToImage,
                      content: articlesList[index].content,
                      url: articlesList[index].url,
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
                child: urlToImage != null ? Image.network(urlToImage, fit: BoxFit.cover) : Container(),
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