import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/walk_entry_api.dart';
import 'package:mobile_client/src/models/diary.dart';
import 'package:mobile_client/src/models/walk_entry.dart';
import 'package:mobile_client/src/widgets/walkEntry/walk_entry_container.dart';

// 呼び出されるページクラス
class WalkEntryPage extends StatefulWidget {
  @override
  State<WalkEntryPage> createState() => _WalkEntryPageState();
}

// ページの内部処理
class _WalkEntryPageState extends State<WalkEntryPage> {
  List<WalkEntry> walkEntries = [];
  List<Diary> diaries = [];
  // 初期化時に呼ぶ関数。useEffectのような？
  @override
  void initState() {
    super.initState();
    fetchDogAndSet();
  }

// async/awaitはFuture型になる
  Future fetchDogAndSet() async {
    try {
      var res = await fetchWalkEntries();
      print(res);
      if (res != null) {
        var parsed = json.decode(res) as List<dynamic>;
        // flutterが用意しているセッター。stateに対して変更を加えることができる。
        // setStateの命名を変えることはできない？
        setState(() {
          walkEntries = parsed
              .map((item) {
                if (item is Map<String, dynamic>) {
                  return WalkEntry.fromJson(item);
                } else {
                  return null;
                }
              })
              .where((item) => item != null)
              .cast<WalkEntry>()
              .toList();
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    print(walkEntries);

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('散歩記録一覧'),
        ),
        ElevatedButton(onPressed: fetchDogAndSet, child: Text('取得する')),
        if (walkEntries.isEmpty)
          Text('散歩記録がありません')
        else
          ...walkEntries.expand(
              (walkEntry) => [WalkEntryContainer(walkEntry: walkEntry)]),
      ],
    );
  }
}
