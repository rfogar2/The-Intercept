import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_intercept/pages/HomePage.dart';
import 'package:the_intercept/usecases/IGetFeeds.dart';

void main() => runApp(TheIntercept());

class TheIntercept extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<IGetFeeds>(
      builder: (_) => IGetFeedsImpl(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      )
    );
  }
}