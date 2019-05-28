import 'package:flutter_app/entity/video.dart';
import 'package:html/dom.dart';
import 'package:xpath/xpath.dart';
import 'package:html/parser.dart' show parse;

class Parser91 {
  String pageData;
  Document document;

  Parser91(this.pageData) {
    document = parse(this.pageData);
  }

  List<VideoInfo91> parseListData() {
    List<VideoInfo91> data;
    var listchannel = this.document.querySelectorAll('.listchannel');
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

  String parseDetailData() {
    String data;
    data = this.document.querySelector('source').attributes['src'];
    return data;
  }
}
