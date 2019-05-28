import 'package:flutter_app/entity/video.dart';
import 'package:html/dom.dart';
import 'package:xpath/xpath.dart';
import 'package:html/parser.dart' show parse;

class ParserList91 {
  String pageData;

  ParserList91(this.pageData);

  List<VideoInfo91> parseData() {
    List<VideoInfo91> hehe;
    var document = parse(pageData);
    var listchannel = document.querySelectorAll('.listchannel');
    hehe = listchannel.map((item) {
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
    return hehe;
  }
}
