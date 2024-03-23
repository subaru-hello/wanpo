import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_client/src/api/diary_api.dart';
import 'package:mobile_client/src/api/dog_api.dart';
import 'package:mobile_client/src/models/dog.dart';
import 'package:mobile_client/src/utils/localstorageUtils.dart';
import 'package:mobile_client/src/widgets/diary/form.dart';

class DiaryCreatePage extends StatefulWidget {
  @override
  State<DiaryCreatePage> createState() => _DiaryCreateState();
}

class _DiaryCreateState extends State<DiaryCreatePage> {
  String title = "";
  String description = "";
  final storage = FlutterSecureStorage();
  late Future<String> userSub;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  void _handleTitleSaved(String value) {
    setState(() {
      title = value;
    });
  }

  void _handleDeacriptionSaved(String value) {
    setState(() {
      description = value;
    });
  }

  Future _submitForm() async {
    print("hello");
    if (_formKey.currentState!.validate()) {
      // ここでregisterDiary関数を呼び出す
      await registerDiary(title: title, description: description)
          .then((result) {
        // 成功した場合の処理
        print('Diary registered successfully $title $description');
      }).catchError((error) {
        // エラー処理
        print('Failed to register diary: $error');
      });
    }
  }

  Future<List<Dog>> getDogs() async {
    final userSub = await SecureTokenStorage.getStorageValue("userSub");
    final responseDogs = await fetchOwnedDogs(userSub); // これはAPI呼び出しの仮の関数
    List<Dog> dogs = (responseDogs['dogs'] as List)
        .map((dogJson) => Dog.fromJson(dogJson))
        .toList();
    return dogs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('日記を作成')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DiaryForm(
              formKey: _formKey,
              onTitleSaved: _handleTitleSaved,
              onDeacriptionSaved: _handleDeacriptionSaved,
              onSubmitForm: _submitForm,
            ),
            // タイトルの表示（デバッグ用）
            Text('タイトル: $title'),
            Text('説明書き: $description'),
            FutureBuilder<List<Dog>>(
              future: getDogs(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  return Text('エラーが発生しました');
                } else if (snapshot.hasData) {
                  // dogsデータがList<Map<String, dynamic>>の形式であると仮定
                  final dogs = snapshot.data!;
                  return ListView.builder(
                    shrinkWrap: true, // Column内でListViewを使用する場合に必要
                    itemCount: dogs.length,
                    itemBuilder: (context, index) {
                      // 各犬の情報を表示するウィジェットを返す
                      final dog = dogs[index];
                      print('===dgs===');
                      print(dog.dogOwnerProfileId);
                      // TODO: デフォルトの写真を用意する
                      return ListTile(
                        title: Text(dog.nickname ?? '名前未設定'),
                        subtitle: Text('出身地: ${dog.birthArea ?? '不明'}'),
                      );
                    },
                  );
                } else {
                  return Text('データが存在しません');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
