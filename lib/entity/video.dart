import 'package:html/dom.dart';

class VideoInfo {
  String title;
  String duration;
  String author;
  String favorite;
  String views;
  int comments;

  VideoInfo.fromDocument(Document document) {
    var dataListchannel = document.querySelectorAll('.listchannel');
    var titleList = dataListchannel.map((data) {
      data.querySelector('span').text;
    }).toList();
  }
}
