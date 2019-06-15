import 'package:flutter/material.dart';
import 'package:flutter_app/pages/My91Page.dart';
import 'package:flutter_app/pages/MyToolsPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> homeContent = [My91Page(), MyToolsPage()];

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
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              this._currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.wc), title: Text('91Porn')),
            BottomNavigationBarItem(icon: Icon(Icons.build), title: Text('工具箱'))
          ],
        ),
      ),
    );
  }
}
