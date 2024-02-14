import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/diary_api.dart';
import 'package:mobile_client/src/models/diary.dart';
import 'dart:convert';

import 'package:mobile_client/src/widgets/image_from_s3.dart';

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
      print("error=======");
    }
  }

  // widgetをbuildする
  Widget build(BuildContext context) {
    // diaryを取得する関数を定義
    print(diaries);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('日記'),
        ),
        ElevatedButton(onPressed: fetchDiaryAndSet, child: Text('取得する')),
        if (diaries.isEmpty)
          Text('日記がありません')
        else
          ...diaries
              .expand((diary) => [
                    Text(diary.description),
                    Column(
                      children: [
                        Center(child: Text("画像")),
                        SizedBox(
                          height: 200,
                          child: ImageFromS3(imagePath: diary.coverImagePath),
                        ),
                      ],
                    ),
                  ])
              .toList(),
      ],
    );
  }
}
