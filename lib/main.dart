import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_intercept/pages/NavigationPage.dart';
import 'package:the_intercept/usecases/IGetFeeds.dart';

import 'usecases/NavigationDrawerUseCase.dart';

void main() => runApp(TheIntercept());

class TheIntercept extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<IGetFeeds>(
          builder: (_) => IGetFeedsImpl(),
          dispose: (_, IGetFeeds value) => value?.dispose()
        ),
        Provider<NavigationDrawerUseCase>(
          builder: (_) => NavigationDrawerUseCase(0),
          dispose: (_, NavigationDrawerUseCase value) => value?.dispose()
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: NavigationPage(),
      )
    );
  }
}