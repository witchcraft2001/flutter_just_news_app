import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleDetailsScreenWidget extends StatelessWidget {
  final String title;
  final String posterUrl;
  final String content;
  final String url;
  final int index;

  ArticleDetailsScreenWidget({
    Key key,
    this.title,
    this.posterUrl,
    this.content,
    this.url,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            pinned: true,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                title,
                maxLines: 2,
                style: TextStyle(shadows: <Shadow>[
                  Shadow(offset: Offset(2, 2), blurRadius: 3),
                ], fontSize: 16.0),
              ),
              background: Hero(
                tag: 'photo{$index}',
                child: Stack(
                  children: <Widget>[
                    posterUrl != null
                        ? Image.network(
                            posterUrl,
                            fit: BoxFit.cover,
                          )
                        : Container(),
                    Container(
                      height: MediaQuery.of(context).size.width * 0.8,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            const Color(0xDD000000),
                            const Color(0x00000000),
                            const Color(0x00000000),
                            const Color(0xDD000000),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.launch),
                tooltip: "Open full text article",
                onPressed: _launchUrl,
              ),
            ],
          ),
        ],
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            content,
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }

  _launchUrl() async {
    //todo: show error message when can't launch url
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
