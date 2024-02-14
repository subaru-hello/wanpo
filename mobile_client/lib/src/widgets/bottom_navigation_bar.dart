import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onSelectNavItem;

  const CustomBottomNavigationBar({
    Key? key,
    required this.currentIndex,
    required this.onSelectNavItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'ホーム',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'お気に入り',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_walk),
          label: '散歩',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.book),
          label: '日記',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Color.fromARGB(255, 183, 90, 74),
      unselectedItemColor: Color.fromARGB(179, 255, 147, 52),
      onTap: onSelectNavItem,
    );
  }
}
