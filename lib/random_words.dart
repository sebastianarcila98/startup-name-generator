// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _randwordPairs = <WordPair>[];
  final _savedPairs = <WordPair>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WordPair Generator'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            onPressed: _pushSaved,
          )
        ],
      ),
      body: _buildList(),
    );
  }

  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          final tiles = _savedPairs.map(
            (WordPair pair) {
              return ListTile(
                title: Text(pair.asPascalCase),
              );
            },
          );

          final divided = tiles.isNotEmpty
              ? ListTile.divideTiles(context: context, tiles: tiles).toList()
              : <Widget>[];

          return Scaffold(
            appBar: AppBar(
              title: Text('Saved WordPairs'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemBuilder: (BuildContext context, int item) {
        if (item.isOdd) return Divider();

        int index = item ~/ 2;

        if (index >= _randwordPairs.length) {
          _randwordPairs.addAll(generateWordPairs().take(10));
        }

        return _buildRow(_randwordPairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _savedPairs.contains(pair);

    return ListTile(
      title: Text(pair.asPascalCase),
      trailing: Icon(
        alreadySaved ? Icons.favorite : Icons.favorite_border,
        color: alreadySaved ? Colors.red : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _savedPairs.remove(pair);
          } else {
            _savedPairs.add(pair);
          }
        });
      },
    );
  }
}
