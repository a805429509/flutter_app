import 'package:flutter/material.dart';
import 'package:flutter_app/components/My91TabPage.dart';
import 'package:flutter_app/config/Config91.dart';

class My91Page extends StatefulWidget {
  @override
  _My91PageState createState() => _My91PageState();
}

class _My91PageState extends State<My91Page>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: new Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            TabBar(
                isScrollable: true,
                controller: _tabController,
                tabs: Config91.videoCategories.keys.map((String key) {
                  return Tab(
                      child: Text(
                    key,
                    style: TextStyle(backgroundColor: Colors.blue),
                  ));
                }).toList()),
          ],
        ),
      ),
      body: TabBarView(
          controller: _tabController,
          children: Config91.videoCategories.values.map((String url) {
            return Tab(
              child: new My91TabPage(url),
            );
          }).toList()),
    );
  }
}
