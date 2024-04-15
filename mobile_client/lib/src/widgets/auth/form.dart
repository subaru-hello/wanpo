import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final ValueChanged<String> onEmailSaved; // 親コンポーネントにデータを渡すためのコールバック
  final ValueChanged<String> onPasswordSaved; // 親コンポーネントにデータを渡すためのコールバック
  final Future<dynamic> Function() onSubmitForm; // 親コンポーネントにデータを渡すためのコールバック

  LoginForm({
    Key? key,
    required this.formKey,
    required this.onEmailSaved, // コンストラクタで受け取る
    required this.onPasswordSaved, // コンストラクタで受け取る
    required this.onSubmitForm, // コンストラクタで受け取る
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            // decoration: const InputDecoration(
            //     // hintText: 'ポチの日記...',
            //     ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'メールアドレスを入力してください';
              }
              return null;
            },
            onChanged: (value) => onEmailSaved(value), // フォームが保存されたらコールバックを実行
          ),
          TextFormField(
            // decoration: const InputDecoration(
            //   hintText: 'ポチの毎日を記録するノートです。',
            // ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'パスワードを入力してください';
              }
              return null;
            },
            onChanged: (value) =>
                onPasswordSaved(value), // フォームが保存されたらコールバックを実行
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  // formKey.currentState!.save(); // これによりonSavedが呼び出される
                  onSubmitForm();
                }
              },
              child: Center(child: const Text('ログイン')),
            ),
          ),
        ],
      ),
    );
  }
}
