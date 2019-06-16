import 'package:flutter/material.dart';
import 'package:flutter_app/config/ConfigFAQ.dart';

class MyFAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('你有这些困惑吗？'),
        centerTitle: true,
      ),
      body: ListView(
        children: ConfigFAQ.faq.keys.map((String question) {
          return ListTile(
            title: Text(
              question,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              ConfigFAQ.faq[question],
              style: TextStyle(fontSize: 15.0),
            ),
          );
        }).toList(),
      ),
    );
  }
}
