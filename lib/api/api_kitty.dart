import 'package:flutter_app/entity/torrent.dart';
import 'package:flutter_app/parser/ParserKitty.dart';
import 'package:http/http.dart' as http;

class ApiKittyList {
  Future<List<Torrent>> getTorrentListByName(String name) async {
    var http2 = new http.Client();
    var page1 =
        await http2.post('http://newbtkitty.co/', body: {'keyword': name});
    if (page1.statusCode == 302) {
      var page2 = await http2
          .get('http://newbtkitty.co' + page1.headers['location'].toString());
      var data = ParserKitty(page2.body).parseListData();
      return data;
    }
    var data = ParserKitty(page1.body).parseListData();
    return data;
  }
}
