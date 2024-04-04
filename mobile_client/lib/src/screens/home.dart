import 'package:flutter/material.dart';
import 'package:mobile_client/src/contexts/navigator_contexts.dart';
import 'package:mobile_client/src/screens/contact.dart';
import 'package:mobile_client/src/screens/diary/create_diary_page.dart';
import 'package:mobile_client/src/screens/diary/diary_page.dart';
import 'package:mobile_client/src/screens/dog_page.dart';
import 'package:mobile_client/src/screens/privacy_policy.dart';
import 'package:mobile_client/src/screens/top_page.dart';
import 'package:mobile_client/src/screens/walk-entry/walk_entry_page.dart';
import 'package:mobile_client/src/widgets/bottom_navigation_bar.dart';
import 'package:mobile_client/src/widgets/drawer.dart';
import 'package:mobile_client/src/screens/word_generator_page.dart';
import 'package:provider/provider.dart';

import 'favorite_page.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

enum NavigationSource { drawer, bottomNavigation }

class _HomeState extends State<Home> {
  var selectedTabName = "top";
  NavigationSource lastNavigationSource = NavigationSource.drawer;
  Widget _getPageWidget() {
    String tabName;
    switch (lastNavigationSource) {
      case NavigationSource.drawer:
      case NavigationSource.bottomNavigation:
        tabName = selectedTabName;
    }

    switch (tabName) {
      case "top":
        return TopPage();
      // case "favorite":
      //   return FavoritePage();
      // case "walkEntry":
      //   return WalkEntryPage(
      //     diaryId: "",
      //   );
      case "diary":
        return DiaryPage();
      case "createDiary":
        return DiaryCreatePage(); // Page to create a new diary entry
      // case "viewDiary":
      //   return ViewDiaryPage(); // Page to view details of a diary entry
      // case "editDiary":
      //   return EditDiaryPage(); // Page to edit an existing diary entry
      // case "deleteDiary":
      //   return DeleteDiaryPage(); // Page or dialog to confirm deletion of a diary entry
      case "dog":
        return DogPage();
      case "contact":
        return ContactPage();
      case "privacyPolicy":
        return PrivacyPolicyPage();
      default:
        throw UnimplementedError('No widget for tabName $tabName');
    }
  }

  void _onSelectDrawerItem(String tabName, BuildContext context) {
    setState(() {
      selectedTabName = tabName;
      lastNavigationSource = NavigationSource.drawer;
    });
    Navigator.pop(context); // Drawerを閉じる
  }

  void _onSelectBottomNavItem(String tabName) {
    setState(() {
      selectedTabName = tabName;
      lastNavigationSource = NavigationSource.bottomNavigation;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page = _getPageWidget();
    return ChangeNotifierProvider<NavigatorNotifierState>(
        // Create an instance of NavigatorNotifierState
        create: (context) => NavigatorNotifierState(),
        child: LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
            appBar: AppBar(
              title: Icon(Icons.pets),
            ),
            // Drawerを追加
            drawer: CustomDrawer(
              onSelectDrawerItem: (tabName) {
                _onSelectDrawerItem(tabName, context);
              },
            ),
            body: Row(children: [
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page, // 現在選択されているページを表示
                ),
              ),
            ]),
            bottomNavigationBar: CustomBottomNavigationBar(
              // currntIndex: selectedBottomNavigationIndex,
              onSelectNavItem: (tabName) {
                _onSelectBottomNavItem(tabName);
              },
            ),
          );
        }));
  }
}
