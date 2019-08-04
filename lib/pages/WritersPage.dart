import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WritersPage extends StatefulWidget {
  WritersPage({Key key}) : super(key: key);

  @override
  _WritersPageState createState() => _WritersPageState();
}

class _WritersPageState extends State<WritersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text("Writers"),
    );
  }
}