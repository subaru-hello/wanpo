import 'package:flutter/material.dart';
import 'package:mobile_client/src/contexts/navigator_contexts.dart';
import 'package:provider/provider.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  // final int currentIndex;
  final Function(String) onSelectNavItem;

  const CustomBottomNavigationBar({
    Key? key,
    // required this.currentIndex,
    required this.onSelectNavItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigatorState = context.watch<NavigatorNotifierState>();

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ホーム',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.favorite),
        //   label: '好き日誌',
        // ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.book_outlined),
        //   label: '散歩',
        // ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: '日記',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pets),
          label: 'わんちゃん',
        ),
      ],
      currentIndex: navigatorState.getTabIndex(navigatorState.currentTabName) <
              navigatorState.getTabNames.length - 2
          ? navigatorState.getTabIndex(navigatorState.currentTabName)
          : 0,
      selectedItemColor: Color.fromARGB(255, 183, 90, 74),
      unselectedItemColor: Color.fromARGB(179, 255, 147, 52),
      onTap: (index) {
        navigatorState.setCurrentTabName(navigatorState.getTabNames[index]);
        onSelectNavItem(navigatorState.getTabNames[index]);
      },
    );
  }
}
