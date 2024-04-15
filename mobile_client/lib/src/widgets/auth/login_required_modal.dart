// login_required_modal.dart
import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/auth_api.dart';
import 'package:provider/provider.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/route/route.dart';

Future<void> showModalIfNeeded(BuildContext context) async {
  AppState appState = Provider.of<AppState>(context, listen: false);
  showDialog(
    context: context,
    barrierDismissible: false, // 画面外をクリックしても消えない
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: Text("ログインが必要です"),
        content: Text("ログインをしてください。"),
        actions: <Widget>[
          TextButton(
            child: Text("ログイン画面"),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              appState.navigateTo(routeLogin);
            },
          ),
          TextButton(
            child: Text("新規登録画面"),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              appState.navigateTo(routeSignUp);
            },
          ),
        ],
      );
    },
  );
}

// login_required_modal.dart
Future<bool> checkTokenAndShowModalIfNeeded() async {
  bool tokenExists = await isLoggedIn();
  print(tokenExists);
  print("↑↑↑↑");
  return tokenExists;
}
