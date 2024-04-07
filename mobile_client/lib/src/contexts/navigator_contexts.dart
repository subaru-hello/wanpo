import 'package:flutter/material.dart';
import 'package:mobile_client/src/route/route.dart';

class NavigatorNotifierState extends ChangeNotifier {
  late String currentTabName = routeHome;
  final List<String> tabNames = [
    routeHome,
    // 'favorite',
    // 'walkEntry',
    routeDiaries,
    routeDogs,
    routePrivacyPolicy,
    routeContact
  ];
  int getTabIndex(String tabName) {
    // wordGeneratorの場合は0を返す
    if (tabName == routeHome) {
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
