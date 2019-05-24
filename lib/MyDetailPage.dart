import 'package:flutter/material.dart';
import 'package:flutter_app/api/api_91porn.dart';

class MyDetailPage extends StatelessWidget {
  Future<void> haha() async {
    Api_91porn().getFirstPageTitle().then((data) {
      print(data.outerHtml);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: MaterialButton(
        onPressed: haha,
        child: Text('打印'),
        color: Colors.orange,
      )),
    );
  }
}
