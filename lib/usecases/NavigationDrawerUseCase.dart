import 'package:rxdart/rxdart.dart';

class NavigationDrawerUseCase {
  BehaviorSubject<int> _pageSubject;

  NavigationDrawerUseCase(int currentPage) {
    _pageSubject = BehaviorSubject.seeded(currentPage);
  }

  Observable<int> get pageObservable => _pageSubject.stream;

  void setPage(int newPage) {
    _pageSubject.sink.add(newPage);
  }

  void dispose() {
    _pageSubject.close();
  }
}