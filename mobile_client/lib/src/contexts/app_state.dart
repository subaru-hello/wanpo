import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  // 変数を定義
  var current = WordPair.random();
  var favorites = <WordPair>[];
  // Use a getter for wordCombined
  List<String> get wordCombined =>
      favorites.map((favo) => "${favo.first} ${favo.second}").toList();

  // メソッド
  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }
}
