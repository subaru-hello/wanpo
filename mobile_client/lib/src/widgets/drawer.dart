import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onSelectDrawerItem;

  const CustomDrawer({Key? key, required this.onSelectDrawerItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('ビション Today'),
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => onSelectDrawerItem(0),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorites'),
            onTap: () => onSelectDrawerItem(1),
          ),
          ListTile(
            leading: Icon(Icons.catching_pokemon_outlined),
            title: Text('犬'),
            onTap: () => onSelectDrawerItem(4),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('あなたの散歩日誌'),
            onTap: () => onSelectDrawerItem(2),
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('日記一覧'),
            onTap: () => onSelectDrawerItem(3),
          ),
        ],
      ),
    );
  }
}
