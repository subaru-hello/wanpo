import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/auth_api.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/contexts/navigator_contexts.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:provider/provider.dart';

class WanpoDrawer extends StatelessWidget {
  const WanpoDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    var navigatorNotifierState = context.watch<NavigatorNotifierState>();
    return Drawer(
      child: FutureBuilder(
        future: isLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot);
          List<Widget> drawerItems = [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text('withビション'),
            ),
            // Conditional ListTile based on login status
            if (snapshot.connectionState == ConnectionState.waiting)
              ListTile(
                leading: Icon(Icons.lightbulb_outline_sharp),
                title: Text('Loading...'),
              ),
            // CircularProgressIndicator(),
            if (snapshot.hasData && snapshot.data!)
              ListTile(
                leading: Icon(Icons.account_circle),
                title: Text('マイページ'),
                onTap: () {
                  Navigator.pop(context); // Drawerを閉じる
                },
              ),
            if (snapshot.hasData && !snapshot.data!)
              ListTile(
                leading: Icon(Icons.login),
                title: Text('ログイン'),
                onTap: () {
                  appState.navigateTo(routeLogin);
                  Navigator.pop(context); // Drawerを閉じる
                },
              ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('ホーム'),
              onTap: () {
                navigatorNotifierState.setCurrentTabName(routeHome);
                appState.navigateTo(routeHome);
                Navigator.pop(context); // Drawerを閉じる
              },
            ),
            // ... Repeat for other items if needed ...
            ListTile(
              leading: Icon(Icons.book),
              title: Text('日記一覧'),
              onTap: () {
                navigatorNotifierState.setCurrentTabName(routeDiaries);
                appState.navigateTo(routeDiaries);
                Navigator.pop(context); // Drawerを閉じる
              },
            ),
            ListTile(
              leading: Icon(Icons.pets_outlined),
              title: Text('わんちゃん一覧'),
              onTap: () {
                navigatorNotifierState.setCurrentTabName(routeDogs);
                appState.navigateTo(routeDogs);
                Navigator.pop(context); // Drawerを閉じる
              },
            ),
            ListTile(
              leading: Icon(Icons.policy),
              title: Text('プライバシーポリシー'),
              onTap: () {
                navigatorNotifierState.setCurrentTabName(routePrivacyPolicy);
                appState.navigateTo(routePrivacyPolicy);
                Navigator.pop(context); // Drawerを閉じる
              },
            ),
            ListTile(
              leading: Icon(Icons.contact_mail),
              title: Text('お問い合わせ先'),
              onTap: () {
                navigatorNotifierState.setCurrentTabName(routeContact);
                appState.navigateTo(routeContact);
                Navigator.pop(context); // Drawerを閉じる
              },
            ),
          ];

          return ListView(children: drawerItems);
        },
      ),
    );
  }
}
