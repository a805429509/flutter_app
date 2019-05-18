import 'package:flutter/material.dart';
import 'package:lamp/lamp.dart';


class MyToolsPage extends StatelessWidget {

  void _openflashlight() {
    Lamp.turnOn();
  }

  void _closeflashlight() {
    Lamp.turnOff();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Column(children: <Widget>[
        MaterialButton(color: Colors.blue,child: Text('开灯'),onPressed: _openflashlight,),
        MaterialButton(color: Colors.orange,child: Text('关灯'),onPressed: _closeflashlight,)
      ],),),
    );
  }
}