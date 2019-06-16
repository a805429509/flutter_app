import 'package:flutter/material.dart';
import 'package:flutter_app/pages/My91Page.dart';
import 'package:flutter_app/pages/MyFAQPage.dart';
import 'package:flutter_app/pages/MySearchPage.dart';
import 'package:flutter_app/pages/MyToolsPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> homeContent = [
    My91Page(),
    MySearchPage(),
    MyToolsPage(),
    MyFAQPage()
  ];

  // 准备挪走
  // get _drawer => Drawer(
  //       child: Column(
  //         children: <Widget>[
  //           DrawerHeader(
  //             child: CircleAvatar(
  //               child: Text('haha'),
  //             ),
  //           ),
  //           ListTile(
  //             leading: Icon(Icons.security),
  //             title: Text('安全'),
  //           )
  //         ],
  //       ),
  //     );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: Scaffold(
        body: homeContent[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          // 下面的type可以解决底部超过3个选项的显示问题
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.wc), title: Text('91Porn')),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), title: Text('资源搜索')),
            BottomNavigationBarItem(
                icon: Icon(Icons.build), title: Text('工具箱')),
            BottomNavigationBarItem(icon: Icon(Icons.help), title: Text('FAQ'))
          ],
        ),
      ),
    );
  }
}
