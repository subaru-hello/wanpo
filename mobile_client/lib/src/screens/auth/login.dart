import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/auth_api.dart';
import 'package:mobile_client/src/widgets/diary/form.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  String email = "";
  String password = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

// すでにログイン済みかどうかを確認するAPIを叩く

  void _handleEmailSaved(String value) {
    setState(() {
      email = value;
    });
  }

  void _handlePasswordSaved(String value) {
    setState(() {
      password = value;
    });
  }

  Future _submitForm() async {
    print("hello");
    if (_formKey.currentState!.validate()) {
      // ここでregisterDiary関数を呼び出す
      final res = await login(email: email, password: password);
      print('hello $res');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ログイン')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DiaryForm(
              formKey: _formKey,
              onTitleSaved: _handleEmailSaved,
              onDeacriptionSaved: _handlePasswordSaved,
              onSubmitForm: _submitForm,
            ),
            // タイトルの表示（デバッグ用）
            Text('タイトル: $email'),
            Text('説明書き: $password'),
          ],
        ),
      ),
    );
  }
}
