import 'package:flutter_app/entity/video.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app/parser/Parser91.dart';

class Api91PornList {
  String url = 'http://91porn.com/video.php?category=rf&page=';

  Map<String, String> headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36',
    'X-Forwarded-For': '1.1.1.1,2.2.2.2',
    'Host': '91porn.com',
    'Cookie':
        '__cfduid=d4e783d105daac48d0783fc199f9482451558684392; __utmc=50351329; __utmz=50351329.1558684393.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CLIPSHARE=d4gvm8t7h7tp05ed6rnmao9h31; __dtsu=1EE70445EDA2E75C8F6A3646021EC86E; language=cn_CN; __utma=50351329.1714406464.1558684393.1558684393.1558688147.2; __utmb=50351329.0.10.1558688147'
  };

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

  Map<String, String> headers = {
    'User-Agent':
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36',
    'X-Forwarded-For': '1.1.1.1,2.2.2.2',
    'Host': '91porn.com',
    'Cookie':
        '__cfduid=d4e783d105daac48d0783fc199f9482451558684392; __utmc=50351329; __utmz=50351329.1558684393.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CLIPSHARE=d4gvm8t7h7tp05ed6rnmao9h31; __dtsu=1EE70445EDA2E75C8F6A3646021EC86E; language=cn_CN; __utma=50351329.1714406464.1558684393.1558684393.1558688147.2; __utmb=50351329.0.10.1558688147'
  };

  Future<String> getVideoUrl() async {
    var DetailPageData =
        await Dio().get(this.url, options: Options(headers: this.headers));
    var data = Parser91(DetailPageData.data).parseDetailData();
    return data;
  }
}
