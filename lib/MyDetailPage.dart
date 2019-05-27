import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_91porn.dart';
import 'package:flutter_app/entity/video.dart';

class MyDetailPage extends StatefulWidget {
  @override
  _MyDetailPageState createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  List<VideoInfo91> data = [];
  int pageNum = 1;

  @override
  void initState() {
    super.initState();
    getVideo();
  }

  Future<void> getVideo() async {
    debugPrint('123');
    List<VideoInfo91> _data =
        await Api91Porn().getFirstPage(this.pageNum.toString());
    debugPrint(_data.length.toString());
    setState(() {
      this.data.addAll(_data);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (this.data.length == 0) {
      return Center(
        child: Text('数据加载中..........'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, i) {
          if (i >= this.data.length - 10) {
            this.pageNum += 1;
            getVideo();
          }
          return Container(
              padding: EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Image.network(
                    this.data[i].img_url,
                    height: 90.0,
                    width: 120.0,
                    fit: BoxFit.cover,
                  ),
                  new Expanded(
                      child: ListTile(
                    title: Text(
                      this.data[i].title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ))
                ],
              ));
        },
      );
    }
  }
}
