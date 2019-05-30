import 'package:flutter/rendering.dart';
import 'package:flutter_app/entity/video.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/parser/Parser91.dart';
import 'package:flutter_app/utils/tools.dart';
import 'package:html/parser.dart' show parse;
import 'dart:convert';

class Api91PornList {
  String url = 'http://91porn.com/video.php?category=rf&page=';

  Map<String, String> headers = Tools().getFakeHeaders();

  Future<List<VideoInfo91>> getPageData(String pageNum) async {
    // 请求数据拿到页面
    // http会解析utf-8会有错误
    // var pageData = await http.get(this.url, headers: this.headers);
    var listPageData = await Dio()
        .get(this.url + pageNum, options: Options(headers: this.headers));

    // 只把string传过去，解析相关的全部拿走
    var data = Parser91(listPageData.data).parseListData();

    return data;
  }
}

class Api91PornDetail {
  String url;
  Api91PornDetail(this.url);

  Map<String, String> headers = Tools().getFakeHeaders();

  Future<String> getVideoUrl() async {
    var detailPageData =
        await Dio().get(this.url, options: Options(headers: this.headers));
    var data = Parser91(detailPageData.data).parseDetailData();
    // var videoUrlElement = await Dio().post('https://kentxxq.com/nodeapi/',
    //     data: {"token": "qwer", "param1": data[0], "param2": data[1]});
    var videoUrlElement = await Dio().post('https://kentxxq.com/nodeapi/',
        data: {"token": "qwer", "param1": data[0], "param2": data[1]});

    var document = parse(videoUrlElement.data);
    var videoUrl =
        document.querySelector('source').attributes['src'].toString();
    return videoUrl;
  }
}
