import 'package:english_words/english_words.dart' as ew;
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';


class MyListView extends StatefulWidget {
  @override
  _MyListViewState createState() => _MyListViewState();
}

class _MyListViewState extends State<MyListView> {
  final List<WordPair> _suggestions = <WordPair>[];

  Future<Null> _refresh() async {
    this._suggestions.clear();
    await this._suggestions.addAll(ew.generateWordPairs().take(20));
    return;
  }

  Widget _buildSuggestions() {
    return Container(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: _refresh,
          child: new ListView.builder(itemBuilder: (BuildContext context,int i){
            if(i>=this._suggestions.length){
              this._suggestions.addAll(ew.generateWordPairs().take(5));
            }
            return Container(child: Column(children: <Widget>[
              _buildRow(this._suggestions[i], i),
              new Divider(height: 2.0,),
            ],),);
          },),
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
