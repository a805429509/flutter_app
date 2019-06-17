import 'package:flutter_app/entity/video.dart';
import 'package:html/parser.dart' show parse;

class Parser91 {
  String pageData;

  Parser91(this.pageData);

  List<VideoInfo91> parseListData() {
    var document = parse(this.pageData);
    List<VideoInfo91> data;
    var listchannel = document.querySelectorAll('.listchannel');
    data = listchannel.map((item) {
      // 拿到标题
      var title = item.querySelectorAll('a')[1].attributes['title'];
      // 拿到视频地址
      var videoPage = item.querySelectorAll('a')[1].attributes['href'];
      // 拿到图片的url
      String imageUrl = '';
      var imageUrls = item.querySelectorAll('img');
      for (var item in imageUrls) {
        if (item.attributes['width'] == 120.toString() &&
            item.attributes['height'] == 90.toString()) {
          imageUrl = item.attributes['src'];
        }
      }

      // 拿到时长
      RegExp regDuration = new RegExp(r'\d{1,3}\:\d{2}');
      var duration = regDuration.firstMatch(item.outerHtml).group(0).toString();

      // 拿到上传时间
      RegExp regPostDate = new RegExp(r'\d.*\s前');
      var postDate = regPostDate
          .firstMatch(item.outerHtml)
          .group(0)
          .toString()
          .replaceAll(' ', '');

      // 拿到作者

      // var duration = item.querySelector('');
      // var tree = ETree.fromString(this.pageData);
      // var duration = tree.xpath('//*[contains(@class,"info")])');
      // debugPrint(duration);
      return VideoInfo91(title, imageUrl, videoPage, duration, postDate);
    }).toList();
    return data;
  }

  List<String> parseDetailData() {
    RegExp reg1 = new RegExp(r'strencode\(\".*\"\)');
    var match1 = reg1.firstMatch(this.pageData);
    var decodeCode = match1.group(0).toString();

    RegExp reg2 = RegExp(r'\".*?\"');
    var paramIterable = reg2.allMatches(decodeCode);
    var param1 =
        paramIterable.toList()[0].group(0).toString().replaceAll('\"', "");
    var param2 =
        paramIterable.toList()[1].group(0).toString().replaceAll('\"', "");
    return [param1, param2];
  }
}
