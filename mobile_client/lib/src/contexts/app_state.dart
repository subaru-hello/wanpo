import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:mobile_client/src/screens/auth/login.dart';
import 'package:mobile_client/src/screens/contact.dart';
import 'package:mobile_client/src/screens/diary/create_diary_page.dart';
import 'package:mobile_client/src/screens/diary/diary_page.dart';
import 'package:mobile_client/src/screens/dog_page.dart';
import 'package:mobile_client/src/screens/privacy_policy.dart';
import 'package:mobile_client/src/screens/top_page.dart';

class AppState extends ChangeNotifier {
  // 変数を定義
  var current = WordPair.random();
  var favorites = <WordPair>[];
  late Widget currentPage = TopPage();
  // 結合させた値のゲッター
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

// navigator
  void navigateTo(String routeName) {
    switch (routeName) {
      case routeHome:
        currentPage = TopPage();
      case routeDogs:
        currentPage = DogPage();
      case routeDiaries:
        currentPage = DiaryPage();
      case routeLogin:
        currentPage = LoginPage();
      case routeCreateDiaries:
        currentPage = DiaryCreatePage();
      case routeContact:
        currentPage = ContactPage();
      case routePrivacyPolicy:
        currentPage = PrivacyPolicyPage();
      default:
        currentPage = TopPage();
    }
    notifyListeners();
  }
}
