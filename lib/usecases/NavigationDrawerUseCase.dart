import 'package:rxdart/rxdart.dart';

abstract class NavigationDrawerUseCase {
  Observable<int> get pageObservable;
  void setPage(int newPage);
  void dispose();
}

class NavigationDrawerUseCaseImpl extends NavigationDrawerUseCase {
  BehaviorSubject<int> _pageSubject;

  NavigationDrawerUseCaseImpl(int currentPage) {
    _pageSubject = BehaviorSubject.seeded(currentPage);
  }

  @override
  Observable<int> get pageObservable => _pageSubject.stream;

  void setPage(int newPage) {
    _pageSubject.sink.add(newPage);
  }

  void dispose() {
    _pageSubject.close();
  }
}