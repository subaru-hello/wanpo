import 'package:flutter/material.dart';
import 'package:mobile_client/src/contexts/navigator_contexts.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatelessWidget {
  final Function(String) onSelectDrawerItem;

  const CustomDrawer({Key? key, required this.onSelectDrawerItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var navigatorNotifierState = context.watch<NavigatorNotifierState>();
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('withビション'),
            decoration: BoxDecoration(
              color: Colors.amber,
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('ホーム'),
            onTap: () {
              navigatorNotifierState.setCurrentTabName("wordGenerator");
              onSelectDrawerItem("wordGenerator");
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('好き日誌'),
            onTap: () {
              navigatorNotifierState.setCurrentTabName("favorite");
              onSelectDrawerItem("favorite");
            },
          ),
          ListTile(
            leading: Icon(Icons.book_outlined),
            title: Text('わんちゃんの散歩日誌'),
            onTap: () {
              navigatorNotifierState.setCurrentTabName("walkEntry");
              onSelectDrawerItem("walkEntry");
            },
          ),
          ListTile(
            leading: Icon(Icons.book),
            title: Text('日記一覧'),
            onTap: () {
              navigatorNotifierState.setCurrentTabName("diary");
              onSelectDrawerItem("diary");
            },
          ),
          ListTile(
            leading: Icon(Icons.pets_outlined),
            title: Text('わんちゃん一覧'),
            onTap: () {
              navigatorNotifierState.setCurrentTabName("dog");
              onSelectDrawerItem("dog");
            },
          ),
          ListTile(
            leading: Icon(Icons.pets_outlined),
            title: Text('プライバシーポリシー'),
            onTap: () {
              navigatorNotifierState.setCurrentTabName("privacyPolicy");
              onSelectDrawerItem("privacyPolicy");
            },
          ),
          ListTile(
            leading: Icon(Icons.pets_outlined),
            title: Text('お問い合わせ先'),
            onTap: () {
              navigatorNotifierState.setCurrentTabName("contact");
              onSelectDrawerItem("contact");
            },
          ),
        ],
      ),
    );
  }
}
