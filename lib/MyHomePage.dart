import 'package:flutter/material.dart';
import 'package:lamp/lamp.dart';

class MyHomePage extends StatelessWidget {
  void _openflashlight() {
    Lamp.turnOn();
  }

  void _closeflashlight() {
    Lamp.turnOff();
  }

  get _driver => Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueGrey),
              child: Center(child: Text('drawer')),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        drawer: _driver,
        appBar: AppBar(
          title: Text('主页'),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                onPressed: _openflashlight,
                child: Text('开灯'),
                color: Colors.red,
              ),
              MaterialButton(
                onPressed: _closeflashlight,
                child: Text('关灯'),
                color: Colors.blue,
              ),
              MaterialButton(
                onPressed: () => Navigator.pushNamed(context, '/detail'),
                child: Text('跳转detail'),
                color: Colors.green,
              ),
              MaterialButton(
                color: Colors.deepOrange,
                onPressed: () => Navigator.pushNamed(context, '/listview'),
                child: Text('跳转listview'),
              ),
              MaterialButton(
                color: Colors.deepOrange,
                onPressed: () => Navigator.pushNamed(context, '/bie'),
                child: Text('bie'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
