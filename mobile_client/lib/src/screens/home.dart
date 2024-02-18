import 'package:flutter/material.dart';
import 'package:mobile_client/src/screens/diary/diary_page.dart';
import 'package:mobile_client/src/screens/dog_page.dart';
import 'package:mobile_client/src/widgets/bottom_navigation_bar.dart';
import 'package:mobile_client/src/widgets/drawer.dart';
import 'package:mobile_client/src/screens/word_generator_page.dart';
import 'package:mobile_client/src/screens/walk_entry.dart';

import 'favorite_page.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

enum NavigationSource { drawer, bottomNavigation }

class _HomeState extends State<Home> {
  var selectedBottomNavigationIndex = 0;
  var selectedDrawerIndex = 0;
  NavigationSource lastNavigationSource = NavigationSource.drawer;
  Widget _getPageWidget() {
    int index;
    switch (lastNavigationSource) {
      case NavigationSource.drawer:
        index = selectedDrawerIndex;
      case NavigationSource.bottomNavigation:
        index = selectedBottomNavigationIndex;
    }

    switch (index) {
      case 0:
        return WordGeneratorPage();
      case 1:
        return FavoritePage();
      case 2:
        return WalkEntryPage();
      case 3:
        return DiaryPage();
      case 4:
        return DogPage();
      default:
        throw UnimplementedError('No widget for index $index');
    }
  }

  void _onSelectDrawerItem(int index, BuildContext context) {
    setState(() {
      selectedDrawerIndex = index;
      lastNavigationSource = NavigationSource.drawer;
    });
    Navigator.pop(context); // Drawerを閉じる
  }

  void _onSelectBottomNavItem(int index) {
    setState(() {
      selectedBottomNavigationIndex = index;
      lastNavigationSource = NavigationSource.bottomNavigation;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget page = _getPageWidget();
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text('with ビション'),
        ),
        // Drawerを追加
        drawer: CustomDrawer(
          onSelectDrawerItem: (index) {
            _onSelectDrawerItem(index, context);
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
          currentIndex: selectedBottomNavigationIndex,
          onSelectNavItem: (index) {
            _onSelectBottomNavItem(index);
          },
        ),
      );
    });
  }
}
