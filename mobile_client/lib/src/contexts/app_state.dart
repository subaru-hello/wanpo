import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:mobile_client/src/screens/auth/login.dart';
import 'package:mobile_client/src/screens/auth/signup.dart';
import 'package:mobile_client/src/screens/auth/verify_code.dart';
import 'package:mobile_client/src/screens/contact.dart';
import 'package:mobile_client/src/screens/diary/create_diary_page.dart';
import 'package:mobile_client/src/screens/diary/diary_page.dart';
import 'package:mobile_client/src/screens/diary/show_diary_page.dart';
import 'package:mobile_client/src/screens/dog/create_dog.dart';
import 'package:mobile_client/src/screens/dog/dog_page.dart';
import 'package:mobile_client/src/screens/dog/show_dog.dart';
import 'package:mobile_client/src/screens/mypage/profile_page.dart';
import 'package:mobile_client/src/screens/privacy_policy.dart';
import 'package:mobile_client/src/screens/top_page.dart';
import 'package:mobile_client/src/screens/walk-entry/create_walk_entry_page.dart';
import 'package:mobile_client/src/widgets/providers/require_login_provider.dart';

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
  void navigateTo(String routeName, {dynamic oneRecord}) {
    print("===routeNavigate===");
    print(routeName);
    switch (routeName) {
      case routeHome:
        currentPage = TopPage();
      case routeDogs:
        currentPage = DogPage();
      case routeDogsCreate:
        currentPage = RequireLoginProvider(child: DogCreatePage());
      case routeDogsDetail:
        currentPage = DogShowPage(dog: oneRecord);
      case routeDiaries:
        currentPage = DiaryPage();
      case routeLogin:
        currentPage = LoginPage();
      case routeSignUp:
        currentPage = SignUpPage();
      case routeVerifyCode:
        currentPage = VerifyCodePage();
      case routeCreateDiaries:
        currentPage = RequireLoginProvider(child: DiaryCreatePage());
      case routeContact:
        currentPage = ContactPage();
      case routePrivacyPolicy:
        currentPage = PrivacyPolicyPage();
      case routeWalkEntryCreate:
        currentPage = RequireLoginProvider(
            child: WalkEntryCreatePage(selectedDiary: oneRecord));
      case routeDiaryDetail:
        currentPage = DiaryShowPage(
          diary: oneRecord,
        );
      case routeProfile:
        currentPage = ProfilePage();
      default:
        currentPage = TopPage();
    }
    print(currentPage);
    notifyListeners();
  }
}
