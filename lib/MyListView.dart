import 'package:english_words/english_words.dart' as ew;
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  List<WordPair> _suggestions = <WordPair>[];

  @override
  void initState() {
    super.initState();
    //初始给5个长度
    this._suggestions.addAll(ew.generateWordPairs().take(5));
  }

  //加一点学习的笔记
  //一个方法加上了async就变成了异步方法，肯定会返回一个Future对象。
  //而Future<void>意味着你不需要手动去返回！
  //一个耗时的操作，比如要请求服务器拿到User数据，那么在内部使用User user=await get_user()获取Future<User> get_user async()数据
  //或者可以，await get_user.then((user)=>{print(user)}).catch((error)=>{print(error)})直接使用
  Future<void> _refresh() async {
    setState(() {
      this._suggestions.clear();
      this._suggestions.addAll(ew.generateWordPairs().take(5));
    });
  }

  Widget _buildSuggestions() {
    return Container(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: new ListView.builder(
            itemBuilder: (BuildContext context, int i) {
              if (i >= this._suggestions.length) {
                this._suggestions.addAll(ew.generateWordPairs().take(5));
              }
              return Container(
                child: Column(
                  children: <Widget>[
                    _buildRow(this._suggestions[i], i),
                    new Divider(
                      height: 2.0,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
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
    return Container(
      child: _buildSuggestions(),
    );
  }
}
