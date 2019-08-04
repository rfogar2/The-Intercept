import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webfeed/webfeed.dart';

abstract class IGetFeeds {
  RssFeed feed;
  Observable<RssFeed> feedObservable;
  getFeed();
  dispose();
}

class IGetFeedsImpl extends IGetFeeds {
  String _rssFeedUrl = "https://theintercept.com/feed/?lang=en";
  RssFeed feed;

  PublishSubject<RssFeed> _feedSubject;

  IGetFeedsImpl() {
    _feedSubject = PublishSubject<RssFeed>();
  }

  Observable<RssFeed> get feedObservable => _feedSubject.stream;

  @override
  getFeed() async {
    try {
      var response = await Dio().get(_rssFeedUrl);
      feed = RssFeed.parse(response.data.toString());
    } catch (e) {

    } finally {
      _feedSubject.sink.add(feed);
    }
  }

  dispose() {
    _feedSubject.close();
  }
}