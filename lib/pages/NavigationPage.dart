import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_intercept/usecases/NavigationDrawerUseCase.dart';
import 'HomePage.dart';
import 'WritersPage.dart';

class NavigationPage extends StatefulWidget {
  NavigationPage({Key key}) : super(key: key);

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  NavigationDrawerUseCase _navigationDrawerUseCase;

  @override
  Widget build(BuildContext context) {
    _navigationDrawerUseCase = Provider.of<NavigationDrawerUseCase>(context);

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder(
            stream: _navigationDrawerUseCase.pageObservable,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text(_drawerPageTitles(snapshot.data));
            }
        ),
        backgroundColor: Colors.black,
      ),
      body: Center(
          child: StreamBuilder(
            stream: _navigationDrawerUseCase.pageObservable,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return _getDrawerWidget(snapshot.data);
            }
          )
      ),
      drawer: _buildDrawer(context)
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Text(
                  "The Intercept",
                  style: TextStyle(color: Colors.white)
              ),
              decoration: BoxDecoration(
                  color: Colors.black
              ),
            ),
            ListTile(
                title: Text(_drawerPageTitles(0)),
                onTap: () {
                  _navigationDrawerUseCase.setPage(0);

                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
            ),
            ListTile(
                title: Text(_drawerPageTitles(1)),
                onTap: () {
                  _navigationDrawerUseCase.setPage(1);

                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                }
            )
          ],
        )
    );
  }

  String _drawerPageTitles(int page) {
    switch (page) {
      case 0:
        return "Home";
      default:
        return "Writers";
    }
  }

  Widget _getDrawerWidget(int page) {
    switch (page) {
      case 0:
        return HomePage();
      default:
        return WritersPage();
    }
  }
}