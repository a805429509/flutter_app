import 'package:flutter/material.dart';
import 'package:flutter_app/MyDetailPage.dart';
import 'package:flutter_app/config/Config91.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _currentIndex = 0;

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
            // TODO:这里的title也需要通过底部菜单动态切换
            title: Text('kentxxq'),
            centerTitle: true,
            bottom: TabBar(
                isScrollable: true,
                controller: _tabController,
                tabs: Config91.videoCategories.keys.map((String key) {
                  return Tab(child: Text(key));
                }).toList()),
          ),
          // TODO:这里的body需要通过底部菜单动态切换
          body: TabBarView(
              controller: _tabController,
              children: Config91.videoCategories.values.map((String url) {
                return Tab(
                  child: new MyDetailPage(url),
                );
              }).toList()),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              setState(() {
                this._currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: new Icon(Icons.home), title: Text('91Porn')),
              BottomNavigationBarItem(
                  icon: new Icon(Icons.wifi), title: Text('wifi'))
            ],
          ),
        ),
      ),
    );
  }
}
