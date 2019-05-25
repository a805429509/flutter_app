import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_91porn.dart';
import 'package:flutter_app/entity/video.dart';

class MyDetailPage extends StatefulWidget {
  @override
  _MyDetailPageState createState() => _MyDetailPageState();
}

class _MyDetailPageState extends State<MyDetailPage> {
  List<VideoInfo> data = [];

  @override
  void initState() {
    super.initState();
    get_video();
  }

  Future<List<VideoInfo>> get_video() async {
    debugPrint('123');
    List<VideoInfo> _data = await Api91Porn().getFirstPage();
    debugPrint(_data.length.toString());
    setState(() {
      this.data = _data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, i) {
        if (this.data.length == 0) {
          return Text(i.toString());
        } else {
          return ListTile(title: Text(this.data[i].title));
        }
      },
    );
  }
}
