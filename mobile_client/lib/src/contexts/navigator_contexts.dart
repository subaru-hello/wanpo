import 'package:flutter/material.dart';

class NavigatorNotifierState extends ChangeNotifier {
  String currentTabName = "top";
  final List<String> tabNames = [
    'top',
    // 'favorite',
    // 'walkEntry',
    'diary',
    'dog',
    'privacyPolicy',
    'contact'
  ];
  int getTabIndex(String tabName) {
    // wordGeneratorの場合は0を返す
    if (tabName == 'top') {
      return 0;
    }

    // それ以外の場合は、List.indexOfを使用してインデックスを検索
    int index = tabNames.indexOf(tabName);

    // 見つからない場合は、indexOfは-1を返すので、その場合の処理も考慮する
    return index >= 0 ? index : -1; // 見つからない場合は-1を返す
  }

  List<String> get getTabNames => tabNames;
  String get getCurrentTabName => currentTabName;

  void setCurrentTabName(String tabName) {
    currentTabName = tabName;
    notifyListeners();
  }
}
