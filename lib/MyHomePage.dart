import 'package:flutter/material.dart';
import 'package:lamp/lamp.dart';

class MyHomePage extends StatelessWidget {
  void _openflashlight() {
    Lamp.turnOn();
  }

  void _closeflashlight() {
    Lamp.turnOff();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'hehe',
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('主页'),
          ),
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
                child: Text('跳转'),
                color: Colors.green,
              )
            ],
          ),
        ),
      ),
    );
  }
}
