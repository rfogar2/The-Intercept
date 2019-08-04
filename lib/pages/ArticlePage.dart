import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:webfeed/webfeed.dart';

class ArticlePage extends StatelessWidget {
  final RssItem article;

  ArticlePage({Key key, this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(article.dc.creator),
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Column(
            children: <Widget>[
              Text(
                article.title,
                style: Theme.of(context).textTheme.display1
              ),
              article.media.thumbnails.isNotEmpty ? Image.network(article.media.thumbnails.first.url) : Container(),
              Html(
                data: article.content.value,
                onLinkTap: (link) { print(link); },
              )
            ],
          )
        )
    );
  }
}