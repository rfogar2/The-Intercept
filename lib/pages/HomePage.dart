import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:the_intercept/usecases/GetFeedUseCase.dart';
import 'package:webfeed/webfeed.dart';

import 'ArticlePage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetFeed _getFeed;
  RefreshController _refreshController = RefreshController(
      initialRefresh: true);

  _onRefresh() async {
    await _getFeed.getFeed();

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    _getFeed = Provider.of<GetFeed>(context);

    return Scaffold(
        body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: false,
            controller: _refreshController,
            onRefresh: _onRefresh,
            child: buildList(context)
        )
    );
  }

  Widget buildList(BuildContext context) {
    return Scrollbar(
      child: StreamBuilder(
          stream: _getFeed.feedObservable,
          builder: (BuildContext context, AsyncSnapshot<RssFeed> snapshot) {
            return ListView.builder(
              itemBuilder: (c, i) => Card(
                margin: EdgeInsets.all(4.0),
                child: GestureDetector(
                    onTap: () => onTap(context, snapshot.data.items[i]),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        snapshot.data.items[i].title,
                        style: Theme.of(context).textTheme.body1,
                      )
                    )
                ),
              ),
              itemExtent: 100.0,
              itemCount: snapshot != null && snapshot.data != null ? snapshot.data.items.length : 0
            );
          }
      )
    );
  }

  onTap(BuildContext context, RssItem item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ArticlePage(article: item)
        )
    );
  }
}