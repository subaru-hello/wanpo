import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/diary_api.dart';
import 'package:mobile_client/src/contexts/app_state.dart';
import 'package:mobile_client/src/models/diary.dart';
import 'package:mobile_client/src/route/route.dart';
import 'package:mobile_client/src/screens/diary/create_diary_page.dart';
import 'package:mobile_client/src/widgets/diary/diary_wrapper.dart';
import 'dart:convert';

import 'package:mobile_client/src/widgets/image_from_s3.dart';
import 'package:provider/provider.dart';

// 外部から呼び出されるページクラス
class DiaryPage extends StatefulWidget {
  @override
  State<DiaryPage> createState() => _DiaryPageState();
}

class DiaryList extends StatelessWidget {
  final List<Diary> diaries;
  final Function(Diary) onTap;
  DiaryList({required this.diaries, required this.onTap});
  @override
  Widget build(BuildContext context) {
    print(diaries);
    return ListView.builder(
      itemCount: diaries.length,
      itemBuilder: (context, index) {
        return DiaryComponent(
          diary: diaries[index],
          onTap: (diary) => onTap(diary),
        );
      },
    );
  }
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
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text('日記'),
            SizedBox(height: 20),
            if (diaries.isEmpty)
              Text('日記がありません')
            else
              Expanded(
                child: DiaryList(
                  diaries: diaries,
                  onTap: (diary) {
                    appState.navigateTo(routeDiaryDetail, oneRecord: diary);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
