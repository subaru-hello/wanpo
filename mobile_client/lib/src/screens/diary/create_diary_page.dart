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
  Dog? selectedDog;
  List<Dog>? dogs;
  final storage = FlutterSecureStorage();
  late Future<String> userSub;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // 初回ローディング時に犬のリストを取得する
    getDogs().then((dogsList) {
      setState(() {
        dogs = dogsList;
      });
    });
  }

  void _handleTitleSaved(String value) {
    setState(() {
      title = value;
    });
  }

  void _handleDogSaved(Dog dog) {
    print('dog');
    print(dog.id);
    setState(() {
      selectedDog = dog;
    });
  }

  void _handleDeacriptionSaved(String value) {
    setState(() {
      description = value;
    });
  }

// Diaryを作成する
  Future _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // ここでregisterDiary関数を呼び出す
      await registerDiary(
              title: title,
              description: description,
              dogId: selectedDog?.id ?? "")
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('選択した犬: '),
                Text(selectedDog?.nickname ?? ""),
              ],
            ),
            dogs == null
                ? CircularProgressIndicator()
                :
                // ローディング完了後、犬のリストを表示
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: dogs!.length,
                    itemBuilder: (context, index) {
                      final dog = dogs![index];
                      final dogImage = dog.profileImagePath != null
                          ? NetworkImage(dog.profileImagePath ?? "")
                          : AssetImage('assets/icon_waji.jpeg')
                              as ImageProvider;
                      return Card(
                        child: InkWell(
                          onTap: () {
                            _handleDogSaved(dog);
                          },
                          child: ListTile(
                            title: Text(dog.nickname),
                            leading: CircleAvatar(
                              backgroundImage: dogImage,
                            ),
                            // タップ領域を拡張するためにトレーリングに空のWidgetを配置
                            trailing: Icon(Icons.pets),
                          ),
                        ),
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
