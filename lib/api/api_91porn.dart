import 'package:flutter_app/entity/video.dart';
import 'package:flutter_app/tools/Parser.dart';
import 'package:html/parser.dart' show parse;
import 'package:http/http.dart' as http;
import 'package:gbk2utf8/gbk2utf8.dart';
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

  Future<List<VideoInfo>> getFirstPage() async {
    // 请求数据拿到页面
    // var pageData = await http.get(this.url, headers: this.headers);
    var pageData =
        await Dio().get(this.url, options: Options(headers: this.headers));

    // String xx = gbk.decode(pageData.data);

    // debugPrint(pageData.data);

    // // 解析一下数据
    var pageDocument = parse(pageData.data);

    // 这里应该是拿到数据以后，交给parse处理完以后返回给页面
    var data = Parser91(pageDocument).parseData();

    return data;
  }
}
