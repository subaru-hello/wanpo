import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/diary_api.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/models/diary.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:mobile_client/src/screens/diary/create_diary_page.dart';
import 'dart:convert';

import 'package:mobile_client/src/widgets/image_from_s3.dart';
import 'package:provider/provider.dart';

// 外部から呼び出されるページクラス
class DiaryPage extends StatefulWidget {
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

//
class _DiaryPageState extends State<DiaryPage> {
  List<Diary> diaries = [];
  //クラスが初期化された時に実行される関数
  @override
  void initState() {
    super.initState();
    fetchDiaryAndSet();
  }

  Future fetchDiaryAndSet() async {
    try {
      var res = await fetchDiaries();
      if (res != null) {
        var parsed = json.decode(res) as List<dynamic>;
        setState(() {
          diaries = parsed.map((json) => Diary.fromJson(json)).toList();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  // widgetをbuildする
  @override
  Widget build(BuildContext context) {
    // diaryを取得する関数を定義
    var appState = context.watch<AppState>();
    print(diaries);
    return Scaffold(
      appBar: AppBar(
        title: Text('日記'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // DiaryCreatePageへ遷移
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DiaryCreatePage()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Text('日記'),
          ),
          // ElevatedButton(onPressed: fetchDiaryAndSet, child: Text('取得する')),
          if (diaries.isEmpty)
            Text('日記がありません')
          else
            ...diaries
                .map((diary) => GestureDetector(
                      onTap: () {
                        appState.navigateTo(routeDiaryDetail, oneRecord: diary);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => DiaryShowPage(diary: diary),
                        //   ),
                        // );
                      },
                      child: Column(
                        children: [
                          Text(diary.description),
                          SizedBox(
                            height: 200,
                            child: ImageFromS3(
                                imagePath: diary.coverImagePath ??
                                    "default-dog-img.png"),
                          ),
                        ],
                      ),
                    ))
                .toList()
        ],
      ),
    );
  }
}
