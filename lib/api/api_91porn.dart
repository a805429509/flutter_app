import 'package:flutter/foundation.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

class Api91Porn {
  String url = 'http://91porn.com/video.php?category=rf&page=' + '1';

  String testUrl = 'https://httpbin.org/headers';

  String testUrl2 = 'https://www.kentxxq.com';

  Map<String, String> headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36',
    'X-Forwarded-For': '1.1.1.1,2.2.2.2',
    'Host': '91porn.com',
    'Cookie':
        '__cfduid=d4e783d105daac48d0783fc199f9482451558684392; __utmc=50351329; __utmz=50351329.1558684393.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CLIPSHARE=d4gvm8t7h7tp05ed6rnmao9h31; __dtsu=1EE70445EDA2E75C8F6A3646021EC86E; language=cn_CN; __utma=50351329.1714406464.1558684393.1558684393.1558688147.2; __utmb=50351329.0.10.1558688147'
  };

  Future<Iterable<Set<String>>> getFirstPageTitle() async {
    // 请求数据拿到页面
    var pageData =
        await Dio().get(this.url, options: Options(headers: this.headers));
    // 解析完成
    var document = parse(pageData.data.toString());
    // 开始定位到数据的部分
    var dataListchannel = document.querySelectorAll('.listchannel');
    // 拿到标题数据
    var titleList = dataListchannel.map((data) {
      data.querySelector('span').text;
    }).toList();

    return titleList;
  }
}
