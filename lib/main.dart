import 'package:flutter/material.dart';
import 'package:flutter_app/MyDetailPage.dart';
import 'package:flutter_app/MyHomePage.dart';
import 'package:flutter_app/MyListView.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter_app',
      theme: new ThemeData(
          // brightness: Brightness.dark,
          // primaryColor: Colors.lightBlue[800],
          // accentColor: Colors.cyan[600],
          ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => MyHomePage(),
        '/detail': (BuildContext context) => MyDetailPage(),
        '/listview': (BuildContext context) => MyListView()
      },
    );
  }
}
