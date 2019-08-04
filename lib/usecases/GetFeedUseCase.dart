import 'package:dio/dio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:webfeed/webfeed.dart';

abstract class GetFeedUseCase {
  Observable<RssFeed> get feedObservable;
  getFeed();
  dispose();
}

class GetFeedUseCaseImpl extends GetFeedUseCase {
  String _rssFeedUrl = "https://theintercept.com/feed/?lang=en";

  BehaviorSubject<RssFeed> _feedSubject;

  GetFeedUseCaseImpl() {
    _feedSubject = BehaviorSubject.seeded(null);
  }

  @override
  Observable<RssFeed> get feedObservable => _feedSubject.stream;

  @override
  getFeed() async {
    try {
      var response = await Dio().get(_rssFeedUrl);
      var feed = RssFeed.parse(response.data.toString());
      _feedSubject.sink.add(feed);
    } catch (e) {

    }
  }

  @override
  dispose() {
    _feedSubject.close();
  }
}