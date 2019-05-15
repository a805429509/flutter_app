import 'package:flutter/material.dart';

class MyDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('detail_page'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              MaterialButton(
                onPressed: () => Navigator.pushNamed(context, '/'),
                color: Colors.lightGreen,
                child: Text('返回根目录'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
