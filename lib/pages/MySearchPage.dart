// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_kitty.dart';
import 'package:flutter_app/entity/torrent.dart';
import 'package:progress_dialog/progress_dialog.dart';

class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  final _controller = TextEditingController();
  List<Torrent> _data = [];
  bool _requsted = false;
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('加载中...');
    // if (this._data.length == 0) {
    //   this._requsted = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('资源页'),
        centerTitle: true,
      ),
      body: Container(
          child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              textInputAction: TextInputAction.search,
              decoration: InputDecoration(labelText: '输入资源'),
              onSubmitted: (String name) async {
                pr.show();
                var data = await ApiKittyList().getTorrentListByName(name);
                setState(() {
                  this._requsted = true;
                  this._data = data;
                });
                pr.hide();
              },
            ),
          ),
          Container(
            child: Expanded(
              child: this._requsted
                  ? ListView(
                      children: this._data.map((item) {
                        return ListTile(
                          title: Text(
                            item.name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Wrap(
                            children: <Widget>[
                              Chip(
                                label: Text('文件数量:' + item.fileCount),
                              ),
                              Chip(
                                label: Text('热度:' + item.hot),
                              ),
                              Chip(
                                label: Text('上传时间:' + item.pushDate),
                              ),
                              Chip(
                                label: Text('连接速度:' + item.speed),
                              ),
                              Chip(
                                label: Text('文件大小:' + item.fileSize),
                              )
                            ],
                          ),
                          // TODO: 把种子一键复制到粘贴板
                          trailing: Icon(Icons.content_copy),
                        );
                      }).toList(),
                    )
                  : Text(''),
            ),
          )
        ],
      )),
    );
  }
}
