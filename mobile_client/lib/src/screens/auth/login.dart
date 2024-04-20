import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/auth_api.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:mobile_client/src/widgets/auth/form.dart';
import 'package:provider/provider.dart';

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
    if (_formKey.currentState!.validate()) {
      var appState = Provider.of<AppState>(context,
          listen: false); // Accessing AppState directly
      final loginRes = await login(email: email, password: password);
      print(loginRes);

      if (loginRes) {
        appState.navigateTo(routeHome);
      } else {
        // Implement validation message display logic here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ログイン')),
      body: Center(
        child: Card(
          margin: EdgeInsets.all(16.0),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: LoginForm(
              formKey: _formKey,
              onEmailSaved: _handleEmailSaved,
              onPasswordSaved: _handlePasswordSaved,
              onSubmitForm: _submitForm,
            ),
          ),
        ),
      ),
    );
  }
}
