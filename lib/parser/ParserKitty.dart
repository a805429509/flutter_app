import 'package:html/parser.dart' show parse;
import 'package:flutter_app/entity/torrent.dart';

class ParserKitty {
  String pageData;

  ParserKitty(this.pageData);

  List<Torrent> parseListData() {
    var document = parse(this.pageData);

    var listcon = document.querySelectorAll('.list-con');

    var data = listcon.map((item) {
      // a标签是标题
      var elementA = item.querySelector('a');
      var listB = elementA.querySelectorAll('b');
      var name = listB.map((b) {
        return b.text;
      }).join('');
      print(elementA.text);
      name = name + elementA.text;

      // 拿到种子的相关信息
      var elementDD = item.querySelector('.option');
      var elementSpan = elementDD.querySelectorAll('span');
      var pushDate = elementSpan[2].querySelector('b').text;
      var fileSize = elementSpan[3].querySelector('b').text;
      var fileCount = elementSpan[4].querySelector('b').text;
      var speed = elementSpan[5].querySelector('b').text;
      var hot = elementSpan[6].querySelector('b').text;

      return Torrent(name, pushDate, fileCount, fileSize, speed, hot);
    }).toList();
    return data;
  }
}
