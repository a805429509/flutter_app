import 'package:flutter/material.dart';
import 'package:flutter_app/MyDetailPage.dart';
import 'package:flutter_app/MyListView.dart';
import 'package:flutter_app/MyToolsPage.dart';

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
    _tabController = new TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyApp',
      home: Container(
        child: Scaffold(
          appBar: AppBar(
            title: Text('主页'),
            centerTitle: true,
            bottom: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(child: Text('内容')),
                Tab(child: Text('列表页')),
                Tab(child: Text('工具'))
              ],
            ),
          ),
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              Tab(child: new MyDetailPage()),
              Tab(child: new MyListView()),
              Tab(child: new MyToolsPage())
            ],
          ),
        ),
      ),
    );
  }
}
