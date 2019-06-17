import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/api/api_91porn.dart';
import 'package:flutter_app/components/VideoPage.dart';
import 'package:flutter_app/entity/video.dart';

class My91TabPage extends StatefulWidget {
  final String url;

  My91TabPage(this.url);

  @override
  _My91TabPageState createState() => _My91TabPageState();
}

class _My91TabPageState extends State<My91TabPage>
    with AutomaticKeepAliveClientMixin {
  List<VideoInfo91> data = [];
  int pageNum = 1;
  bool network = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getVideo();
  }

  Future<void> getVideo() async {
    try {
      List<VideoInfo91> _data = await Api91PornList()
          .getPageData(widget.url, this.pageNum.toString());
      setState(() {
        this.data.addAll(_data);
        debugPrint('首页新加载的条数:' + _data.length.toString());
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        debugPrint('网络不可用');
        this.network = false;
      });
    }
  }

  Future<void> _onRefresh() async {
    setState(() {
      this.data.clear();
    });
    getVideo();
  }

  Widget content(VideoInfo91 item) {
    return Container(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            FadeInImage.assetNetwork(
              placeholder: 'images/huaji.jpeg',
              height: 90.0,
              width: 120.0,
              fit: BoxFit.cover,
              image: item.imgURL,
            ),
            new Expanded(
                child: ListTile(
              title: Text(
                item.title,
                // overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Wrap(
                children: <Widget>[
                  // TODO: 这里还要加上几个信息
                  Chip(
                    label: Text('时长:' + item.duration),
                  ),
                  Chip(
                    label: Text('上传时间:' + item.postDate),
                  ),
                ],
              ),
            ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    if (this.data.length == 0) {
      return this.network
          ? Center(
              child: Text('数据加载中..........',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '你的网络无法看到资源哦～～',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                MaterialButton(
                  onPressed: getVideo,
                  child: Text('重试'),
                  color: Colors.orange,
                )
              ],
            );
    } else {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView.builder(
          itemBuilder: (context, i) {
            if (i >= this.data.length - 10) {
              this.pageNum += 1;
              getVideo();
            }
            var gestureDetector = GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => VideoPage(
                            this.data[i].title, this.data[i].videoPage)));
              },
              child: content(this.data[i]),
            );
            return gestureDetector;
          },
        ),
      );
    }
  }
}
