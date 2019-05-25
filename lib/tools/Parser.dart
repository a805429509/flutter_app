import 'package:flutter/material.dart';
import 'package:flutter_app/entity/video.dart';
import 'package:html/dom.dart';

class Parser91 {
  Document document;

  Parser91(this.document);

  List<VideoInfo> parseData() {
    List<VideoInfo> hehe;
    var listchannel = this.document.querySelectorAll('.listchannel');
    hehe = listchannel.map((item) {
      var title = item.querySelectorAll('a')[1].attributes['title'];
      return VideoInfo(title);
    }).toList();
    return hehe;
  }
}
