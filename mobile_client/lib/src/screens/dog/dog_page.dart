import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/dog_api.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/models/dog.dart';
import 'package:mobile_client/src/route/route.dart';
import 'dart:convert';

import 'package:mobile_client/src/widgets/image_from_s3.dart';
import 'package:provider/provider.dart';

// 外部から呼び出されるページクラス
class DogPage extends StatefulWidget {
  @override
  State<DogPage> createState() => _DogPageState();
}

//
class _DogPageState extends State<DogPage> {
  List<Dog> dogs = [];
  //クラスが初期化された時に実行される関数
  @override
  void initState() {
    super.initState();
    fetchDogAndSet();
  }

  Future fetchDogAndSet() async {
    try {
      var res = await fetchDogs();
      if (res != null) {
        var parsed = json.decode(res) as List<dynamic>;
        setState(() {
          dogs = parsed.map((json) => Dog.fromJson(json)).toList();
        });
      }
    } catch (e) {
      // Handle or log the error
      print(e);
      print("error=======");
    }
  }

  // widgetをbuildする
  @override
  Widget build(BuildContext context) {
    // dogを取得する関数を定義
    var appState = context.watch<AppState>();
    return Scaffold(
      appBar: AppBar(
        title: Text('わんちゃん一覧'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              appState.navigateTo(routeDogsCreate);
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('わんちゃん一覧'),
          ),
          // ElevatedButton(onPressed: fetchDogAndSet, child: Text('取得する')),
          if (dogs.isEmpty)
            Text('わんちゃんがいません')
          else
            ...dogs
                .expand((dog) => [
                      GestureDetector(
                        onTap: () {
                          appState.navigateTo(routeDogsDetail, oneRecord: dog);
                        },
                        child: Column(
                          children: [
                            Text(dog.nickname),
                            Column(
                              children: [
                                SizedBox(
                                  height: 200,
                                  child: ImageFromS3(
                                      imagePath: dog.profileImagePath),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ])
                .toList(),
        ],
      ),
    );
  }
}
