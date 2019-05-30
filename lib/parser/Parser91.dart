import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/entity/video.dart';
import 'package:html/dom.dart';
import 'package:xpath/xpath.dart';
import 'package:html/parser.dart' show parse;

class Parser91 {
  String pageData;

  Parser91(this.pageData);

  List<VideoInfo91> parseListData() {
    var document = parse(this.pageData);
    List<VideoInfo91> data;
    var listchannel = document.querySelectorAll('.listchannel');
    data = listchannel.map((item) {
      //拿到标题
      var title = item.querySelectorAll('a')[1].attributes['title'];
      //拿到视频地址
      var videoPage = item.querySelectorAll('a')[1].attributes['href'];
      //拿到图片的url
      String imageUrl = '';
      var imageUrls = item.querySelectorAll('img');
      for (var item in imageUrls) {
        if (item.attributes['width'] == 120.toString() &&
            item.attributes['height'] == 90.toString()) {
          imageUrl = item.attributes['src'];
        }
      }
      // var img_url = item.querySelectorAll('img')[1].attributes['src'];
      //拿到时长
      // var duration = item.querySelector('');
      // var tree = ETree.fromString(this.pageData);
      // var duration = tree.xpath('//*[contains(@class,"info")])');
      // debugPrint(duration);
      return VideoInfo91(title, imageUrl, videoPage);
    }).toList();
    return data;
  }

  List<String> parseDetailData() {
    RegExp reg1 = new RegExp(r'strencode\(\".*\"\)');
    var match1 = reg1.firstMatch(this.pageData);
    var xx = match1.group(0).toString();

    RegExp reg2 = RegExp(r'\".*?\"');
    var xx2 = reg2.allMatches(xx);
    var param1 = xx2.toList()[0].group(0).toString().replaceAll('\"', "");
    var param2 = xx2.toList()[1].group(0).toString().replaceAll('\"', "");
    debugPrint(param1);
    debugPrint(param2);
    return [param1, param2];
  }
}
