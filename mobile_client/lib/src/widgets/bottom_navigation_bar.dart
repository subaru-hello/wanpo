import 'package:flutter/material.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/contexts/navigator_contexts.dart';
import 'package:provider/provider.dart';

class WanpoBottomNavigationBar extends StatelessWidget {
  const WanpoBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigatorState = context.watch<NavigatorNotifierState>();
    // 現在表示されているタブをアクティブにするため
    int calculatedIndex =
        navigatorState.getTabIndex(navigatorState.currentTabName);
    int privacyAndTermLength = 2;
    int itemCount = navigatorState.tabNames.length - privacyAndTermLength;
    // Ensure the calculatedIndex is within the bounds of the BottomNavigationBar items
    int currentIndex = (calculatedIndex >= 0 && calculatedIndex < itemCount)
        ? calculatedIndex
        : 0;

    var appState = context.watch<AppState>();
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
      currentIndex: currentIndex,
      selectedItemColor: Color.fromARGB(255, 183, 90, 74),
      unselectedItemColor: Color.fromARGB(179, 255, 147, 52),
      onTap: (index) {
        print(navigatorState.getTabNames[index]);
        navigatorState.setCurrentTabName(navigatorState.getTabNames[index]);
        appState.navigateTo(navigatorState.getTabNames[index]);
        // onSelectNavItem(navigatorState.getTabNames[index]);
      },
    );
  }
}
