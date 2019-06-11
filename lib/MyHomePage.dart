import 'package:flutter/material.dart';
import 'package:flutter_app/MyDetailPage.dart';
import 'package:flutter_app/MyListView.dart';
import 'package:flutter_app/MyToolsPage.dart';
import 'package:flutter_app/config/Config91.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tabController =
        new TabController(vsync: this, length: Config91.videoCategories.length);
  }

  get _drawer => Drawer(
        child: Column(
          children: <Widget>[
            DrawerHeader(
              child: CircleAvatar(
                child: Text('haha'),
              ),
            ),
            ListTile(
              leading: Icon(Icons.security),
              title: Text('安全'),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: Container(
        child: Scaffold(
          drawer: _drawer,
          appBar: AppBar(
            title: Text('主页'),
            centerTitle: true,
            bottom: TabBar(
                isScrollable: true,
                controller: _tabController,
                tabs: Config91.videoCategories.keys.map((String key) {
                  return Tab(child: Text(key));
                }).toList()
                // tabs: <Widget>[
                //   Tab(child: Text('内容')),
                //   Tab(child: Text('列表页')),
                //   Tab(child: Text('工具')),
                //   Tab(child: Text('工具')),
                //   Tab(child: Text('工具')),
                //   Tab(child: Text('工具')),
                //   Tab(child: Text('工具')),
                //   Tab(child: Text('工具'))
                // ],
                ),
          ),
          body: TabBarView(
              controller: _tabController,
              children: Config91.videoCategories.values.map((String url) {
                return Tab(
                  child: new MyDetailPage(),
                );
              }).toList()
              // children: <Widget>[
              //   Tab(child: new MyDetailPage()),
              //   Tab(child: new MyListView()),
              //   Tab(child: new MyToolsPage()),
              //   Tab(child: new MyToolsPage()),
              //   Tab(child: new MyToolsPage()),
              //   Tab(child: new MyToolsPage()),
              //   Tab(child: new MyToolsPage()),
              //   Tab(child: new MyToolsPage())
              // ],
              ),
        ),
      ),
    );
  }
}
