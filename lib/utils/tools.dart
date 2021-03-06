import 'dart:math';

class Tools {
  static final _random = new Random();

  static int next(int min, int max) {
    return _random.nextInt(min) + _random.nextInt(max - min);
  }

  static String getRandomIp() {
    String ip = next(1, 254).toString() +
        '.' +
        next(1, 254).toString() +
        '.' +
        next(1, 254).toString() +
        '.' +
        next(1, 254).toString();
    return ip;
  }

  static Map<String, String> getFakeHeaders() {
    return {
      'User-Agent':
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.157 Safari/537.36',
      'X-Forwarded-For': getRandomIp(),
      'Host': '91porn.com',
      'Cookie':
          '__cfduid=d4e783d105daac48d0783fc199f9482451558684392; __utmc=50351329; __utmz=50351329.1558684393.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none); CLIPSHARE=d4gvm8t7h7tp05ed6rnmao9h31; __dtsu=1EE70445EDA2E75C8F6A3646021EC86E; language=cn_CN; __utma=50351329.1714406464.1558684393.1558684393.1558688147.2; __utmb=50351329.0.10.1558688147'
    };
  }
}
