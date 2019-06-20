import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/components/VideoPage.dart';
import 'package:path_provider/path_provider.dart';

class MyStuffPage extends StatefulWidget {
  @override
  _MyStuffPageState createState() => _MyStuffPageState();
}

class _MyStuffPageState extends State<MyStuffPage> {
  String appDocPath;
  Directory directory;
  List<FileSystemEntity> fse = [];

  @override
  void initState() {
    super.initState();
    getFiles();
  }

  void getFiles() async {
    this.directory = await getApplicationDocumentsDirectory();
    this.appDocPath = directory.path;
    setState(() {
      this.fse = this.directory.listSync();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.fse.length == 0) {
      return Center(
        child: Text('没有数据'),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('你的数据'),
          centerTitle: true,
        ),
        body: ListView(
          children:
              this.fse.where((item) => item.path.endsWith('.mp4')).map((item) {
            return Dismissible(
              key: Key('key${item.path.split('/').last}'),
              onDismissed: (dismiss) {
                item.deleteSync();
              },
              background: Container(
                color: Colors.red,
                // 这里使用 ListTile 因为可以快速设置左右两端的Icon
                child: ListTile(
                  leading: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  trailing: Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
              ),
              child: ListTile(
                title: Text(item.path.split('/').last),
                leading: Icon(Icons.ondemand_video),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => VideoPage(
                              item.path.split('/').last, item.uri.toString())));
                },
              ),
            );
          }).toList(),
        ),
      );
    }
  }
}
