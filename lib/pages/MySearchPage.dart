// import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_kitty.dart';
import 'package:flutter_app/entity/torrent.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:flutter/services.dart';

class MySearchPage extends StatefulWidget {
  @override
  _MySearchPageState createState() => _MySearchPageState();
}

class _MySearchPageState extends State<MySearchPage> {
  GlobalKey _scaffold = new GlobalKey();
  final _controller = TextEditingController();
  List<Torrent> _data = [];
  bool _requsted = false;
  ProgressDialog pr;

  @override
  void initState() {
    super.initState();
    // if (this._data.length == 0) {
    //   this._requsted = false;
    // }
  }

  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('正在处理中...');
    return Scaffold(
      key: _scaffold,
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
                var data = await ApiKitty().getTorrentListByName(name);
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
                          trailing: IconButton(
                            icon: Icon(Icons.content_copy),
                            onPressed: () {
                              pr.show();
                              ApiKitty()
                                  .getTorrentLink(item.detailPage)
                                  .then((String torrentLink) {
                                Clipboard.setData(
                                    new ClipboardData(text: torrentLink));
                                pr.hide();
                                Scaffold.of(context).showSnackBar(SnackBar(
                                  content: Text('已复制到粘贴板'),
                                  duration: Duration(seconds: 1),
                                ));
                              });
                            },
                          ),
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
