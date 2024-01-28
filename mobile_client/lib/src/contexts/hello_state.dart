import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class HelloState extends ChangeNotifier {
  // 変数を定義
  var hello = "hello";

  // メソッド
  void getHello() {
    hello;
    notifyListeners();
  }
}
