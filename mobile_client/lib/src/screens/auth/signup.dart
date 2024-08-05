import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/auth_api.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:mobile_client/src/widgets/auth/sign_up_form.dart';
import 'package:provider/provider.dart';

// 新規登録→認証コード入力→マイページトップへ遷移
class SignUpPage extends StatefulWidget {
  @override
  State<SignUpPage> createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
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

  void showPopup(BuildContext context, String errorTxt) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: Text(errorTxt),
          actions: <Widget>[
            TextButton(
              child: Text('閉じる'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void transitionToLogin() {
    var appState = Provider.of<AppState>(context, listen: false);
    appState.navigateTo(routeLogin);
  }

  Future submitForm() async {
    if (_formKey.currentState!.validate()) {
      var appState = Provider.of<AppState>(context,
          listen: false); // Accessing AppState directly
      final loginRes = await signUp(email: email, password: password);
      print(loginRes);

      if (loginRes) {
        print("succeeded!");
        appState.tempEmailRetain(email: email);
        appState.navigateTo(routeVerifyCode);
      } else {
        if (mounted) {
          showPopup(context, "新規登録に失敗しました");
        }
        // Implement validation message display logic here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('新規登録')),
      body: Center(
        child: Container(
          margin: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SignUpForm(
                    formKey: _formKey,
                    onEmailSaved: _handleEmailSaved,
                    onPasswordSaved: _handlePasswordSaved,
                    onSubmitForm: submitForm,
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(16.0),
                  child: TextButton(
                    onPressed: () => transitionToLogin(),
                    child: Text('ログインはこちら'),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
