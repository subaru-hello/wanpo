import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_client/src/api/dog_api.dart';
import 'package:mobile_client/src/api/dog_breed_api.dart';
import 'package:mobile_client/src/models/dog_breed.dart';
import 'package:mobile_client/src/utils/local_storage_utils.dart';
import 'package:mobile_client/src/widgets/dog/form.dart';

class DogCreatePage extends StatefulWidget {
  @override
  State<DogCreatePage> createState() => _DogCreateState();
}

// dogBreed,

class _DogCreateState extends State<DogCreatePage> {
  String nickname = "";
  String? birthArea; // cognitoSubが一致する人をOwnerにする
  DateTime? birthDate; // cognitoSubが一致する人をOwnerにする
  String? profileImagePath; // cognitoSubが一致する人をOwnerにする
  late DogBreed selectedBreed;
  List<DogBreed>? breeds;
  final storage = FlutterSecureStorage();
  late Future<String> cognitoSub;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    //To prevent calling setState() on a disposed widget,
    if (!mounted) return;
    // 初回ローディング時に犬種のリストを取得する
    getDogBreeds().then((breedsList) {
      setState(() {
        breeds = breedsList;
      });
    });
  }

  void handleNicknameSaved(String value) {
    setState(() {
      nickname = value;
    });
  }

  void handleBirthAreaSaved(String value) {
    setState(() {
      birthArea = value;
    });
  }

  void handleBirthDateSaved(DateTime value) {
    setState(() {
      birthDate = value;
    });
  }

  void handleProfileImageSaved(String value) {
    setState(() {
      profileImagePath = value;
    });
  }

// Dogを作成する
  Future _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final cognitoSub = await SecureTokenStorage.getStorageValue("cognitoSub");
      // ここでregisterDog関数を呼び出す
      await registerDog(
              nickname: nickname,
              breedId: selectedBreed.id,
              birthArea: birthArea,
              cognitoSub: cognitoSub)
          .then((result) {
        // 成功した場合の処理
        print('Dog registered successfully $cognitoSub $selectedBreed');
      }).catchError((error) {
        // エラー処理
        print('Failed to register a dog: $error');
      });
    }
  }

  Future<List<DogBreed>> getDogBreeds() async {
    final responseBreeds = await fetchDogBreeds();
    if (responseBreeds == null) {
      print('Failed to fetch or parse dog breeds.');
      return [];
    }

    var parsedBreeds = json.decode(responseBreeds) as List<dynamic>;
    print(responseBreeds);
    List<DogBreed> dogBreeds =
        parsedBreeds.map((breed) => DogBreed.fromJson(breed)).toList();
    return dogBreeds;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('日記を作成')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            DogForm(
              formKey: _formKey,
              onBirthAreaSaved: handleBirthAreaSaved,
              onDateSaved: handleBirthDateSaved,
              onNicknameSaved: handleNicknameSaved,
              onProfileImagePathSaved: handleProfileImageSaved,
              onSubmitForm: _submitForm,
            ),
            // タイトルの表示（デバッグ用）
            Text('名前: $nickname'),
            breeds == null
                ? CircularProgressIndicator()
                :
                // ローディング完了後、犬種のリストを表示
                ListView.builder(
                    shrinkWrap: true,
                    itemCount: breeds!.length,
                    itemBuilder: (context, index) {
                      final breed = breeds![index];
                      final dogImage = breed.profileImagePath != null &&
                              breed.profileImagePath!.isNotEmpty
                          ? NetworkImage(breed.profileImagePath!)
                          : AssetImage('assets/icon_waji.jpeg')
                              as ImageProvider;

                      return Card(
                        child: InkWell(
                          onTap: () {
                            selectedBreed = breed;
                            // handleDogBreedSaved(breed);
                          },
                          child: ListTile(
                            title: Text(breed.name),
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
