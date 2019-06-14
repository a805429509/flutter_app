import 'package:flutter/material.dart';
import 'package:flutter_app/config/Config91.dart';
import 'package:flutter_app/pages/My91Page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  List<Widget> homeContent = [];

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
        body: My91Page(),
      ),
      // home: My91Page(),
      // home: Container(
      //   child: Scaffold(
      //     // drawer: _drawer,
      //     appBar: AppBar(
      //       // TODO:这里的title也需要通过底部菜单动态切换
      //       // title: Text('kentxxq'),
      //       // centerTitle: true,
      //       bottom: TabBar(
      //           isScrollable: true,
      //           controller: _tabController,
      //           tabs: Config91.videoCategories.keys.map((String key) {
      //             return Tab(child: Text(key));
      //           }).toList()),
      //     ),
      //     // TODO:这里的body需要通过底部菜单动态切换
      //     body: TabBarView(
      //         controller: _tabController,
      //         children: Config91.videoCategories.values.map((String url) {
      //           return Tab(
      //             child: new My91TabPage(url),
      //           );
      //         }).toList()),
      //     bottomNavigationBar: BottomNavigationBar(
      //       onTap: (int index) {
      //         setState(() {
      //           this._currentIndex = index;
      //         });
      //       },
      //       currentIndex: _currentIndex,
      //       items: [
      //         BottomNavigationBarItem(
      //             icon: new Icon(Icons.wc), title: Text('91Porn')),
      //         BottomNavigationBarItem(
      //             icon: new Icon(Icons.build), title: Text('工具'))
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
