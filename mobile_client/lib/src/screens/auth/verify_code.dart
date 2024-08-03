import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/auth_api.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:mobile_client/src/widgets/auth/verify_code_form.dart';
import 'package:provider/provider.dart';

class VerifyCodePage extends StatefulWidget {
  @override
  State<VerifyCodePage> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCodePage> {
  String verifyToken = "";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _handleTokenSaved(String value) {
    print(value);
    setState(() {
      verifyToken = value;
    });
  }

  Future _submitForm() async {
    if (_formKey.currentState!.validate()) {
      var appState = Provider.of<AppState>(context,
          listen: false); // Accessing AppState directly
      var email = appState.getEmail();
      print(email);
      print(verifyToken);
      final verifyRes = await verifyCode(verifyCode: verifyToken, email: email);
      print(verifyRes);

      if (verifyRes) {
        print("succeeded!");
        appState.navigateTo(routeHome);
      } else {
        print("failed!");
        // Implement validation message display logic here
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('認証コードを入力')),
      body: Center(
        child: Card(
            margin: EdgeInsets.all(16.0),
            child: VerifyCodeForm(
              formKey: _formKey,
              onVerifyCodeSaved: _handleTokenSaved,
              onSubmitForm: _submitForm,
            )),
      ),
    );
  }
}
