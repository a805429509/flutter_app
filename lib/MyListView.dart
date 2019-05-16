import 'package:english_words/english_words.dart' as ew;
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final List<WordPair> _suggestions = <WordPair>[];

  Widget _buildSuggestions() {
    return new ListView.builder(
      padding: const EdgeInsets.all(19.0),
      itemBuilder: (BuildContext _context, int i) {
        //如果渲染到了最后一个，就给新加进去5个单词组，从而实现了无限下拉
        if (i >= _suggestions.length) {
          print('开始请求新的wordpair,现在长度为' + _suggestions.length.toString());
          _suggestions.addAll(ew.generateWordPairs().take(5));
          print('完成后的长度' + _suggestions.length.toString());
        }
        return Container(
          child: Column(
            children: <Widget>[_buildRow(_suggestions[i], i), new Divider()],
          ),
        );
      },
    );
  }

  Widget _buildRow(WordPair wordpair, int i) {
    print('生成' + i.toString());
    return ListTile(
      title: new Text(wordpair.asPascalCase),
    );
  }

  @override
  Widget build(BuildContext context) {
    //初始给5个长度
    this._suggestions.addAll(ew.generateWordPairs().take(5));
    return Container(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('title'),
        ),
        body: _buildSuggestions(),
      ),
    );
  }
}
