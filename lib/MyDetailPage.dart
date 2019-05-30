import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_91porn.dart';
import 'package:flutter_app/components/VideoPage.dart';
import 'package:flutter_app/entity/video.dart';

class MyDetailPage extends StatefulWidget {
  @override
  _MyDetailPageState createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage>
    with AutomaticKeepAliveClientMixin {
  List<VideoInfo91> data = [];
  int pageNum = 1;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getVideo();
  }

  Future<void> getVideo() async {
    List<VideoInfo91> _data =
        await Api91PornList().getPageData(this.pageNum.toString());
    debugPrint('首页新加载的条数:' + _data.length.toString());
    setState(() {
      this.data.addAll(_data);
    });
  }

  void toVideoPage(String url) {}

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VideoPage(this.data[i].videoPage)));
            },
            child: Container(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: <Widget>[
                    Image.network(
                      this.data[i].imgURL,
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
                )),
          );
        },
      );
    }
  }
}
