import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/components/DeviceInfo.dart';
import 'package:lamp/lamp.dart';

class MyToolsPage extends StatelessWidget {
  void _openflashlight() {
    Lamp.turnOn();
  }

  void _closeflashlight() {
    Lamp.turnOff();
  }

  void _test() {
    new Timer(new Duration(seconds: 2), () {
      print('hahaha');
    });
    print('1212312312');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: <Widget>[
            MaterialButton(
              color: Colors.blue,
              child: Text('开灯'),
              onPressed: _openflashlight,
            ),
            MaterialButton(
              color: Colors.orange,
              child: Text('关灯'),
              onPressed: _closeflashlight,
            ),
            MaterialButton(
              color: Colors.amber,
              child: Text('测试专用'),
              onPressed: _test,
            ),
            MaterialButton(
              color: Colors.yellow,
              child: Text('打印设备信息'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyDevicePage()));
              },
            )
          ],
        ),
      ),
    );
  }
}
