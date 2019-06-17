import 'package:flutter_app/entity/torrent.dart';
import 'package:flutter_app/parser/ParserKitty.dart';
import 'package:http/http.dart' as http;

class ApiKitty {
  var httpClient = new http.Client();

  Future<List<Torrent>> getTorrentListByName(String name) async {
    var page1 =
        await httpClient.post('http://newbtkitty.co/', body: {'keyword': name});
    if (page1.statusCode == 302) {
      var page2 = await httpClient
          .get('http://newbtkitty.co' + page1.headers['location'].toString());
      var data = ParserKitty(page2.body).parseListData();
      return data;
    }
    var data = ParserKitty(page1.body).parseListData();
    return data;
  }

  Future<String> getTorrentLink(String url) async {
    var pageData = await httpClient.get(url);
    var data = ParserKitty(pageData.body).parseDetailPage();
    return data;
  }
}
