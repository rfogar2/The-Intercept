import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:the_intercept/usecases/IGetFeeds.dart';
import 'package:webfeed/webfeed.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  IGetFeeds _iGetFeeds;
  RefreshController _refreshController = RefreshController(initialRefresh: true);

  _onRefresh() async {
    await _iGetFeeds.getFeed();

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    _iGetFeeds = Provider.of<IGetFeeds>(context);

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: _iGetFeeds.feedObservable,
            builder: (BuildContext context, AsyncSnapshot<RssFeed> snapshot) {
              return Text(snapshot != null && snapshot.data != null ? snapshot.data.title : "Loading...");
            }
        ),
      ),
      body: Center(
          child: Scaffold(
              body: SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  child: buildList(context)
              )
          )
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return StreamBuilder(
        stream: _iGetFeeds.feedObservable,
        builder: (BuildContext context, AsyncSnapshot<RssFeed> snapshot) {
          return ListView.builder(
              itemBuilder: (c, i) => Card(
                child: GestureDetector(
                    onTap: () => onTap(context, snapshot.data.items[i]),
                    child: Text(
                      snapshot.data.items[i].title,
                      style: Theme.of(context).textTheme.body1,
                    )
                ),
              ),
              itemExtent: 100.0,
              itemCount: snapshot != null && snapshot.data != null ? snapshot.data.items.length : 0
          );
        }
    );
  }

  onTap(BuildContext context, RssItem item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Scaffold(
                appBar: AppBar(title: Text(item.title)),
                body: SingleChildScrollView(
                    child: Text(item.content.value)
                )
            )
        )
    );
  }

  @override
  void dispose() {
    super.dispose();

    _refreshController.dispose();
    _iGetFeeds.dispose();
  }
}