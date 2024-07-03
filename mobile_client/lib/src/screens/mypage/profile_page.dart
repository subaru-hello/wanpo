import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/auth_api.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:mobile_client/src/screens/mypage/edit_profile.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditPage = false;
  void handleChangeIsEditPage() {
    setState(() {
      isEditPage = !isEditPage;
    });
  }

  void handlerLogout() async {
    var appState = Provider.of<AppState>(context, listen: false);
    await logout();
    appState.navigateTo(routeLogin);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('マイページ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            TextButton(
              onPressed: () => handleChangeIsEditPage(),
              child: !isEditPage ? Text('編集ページ') : Text('戻る'),
            ),
            TextButton(
              onPressed: () => handlerLogout(),
              child: Text('ログアウト'),
            ),
            !isEditPage
                ? Text("マイページ")
                : SizedBox(width: 500, height: 500, child: ProfileEditPage()),
          ],
        ),
      ),
    );
  }
}
