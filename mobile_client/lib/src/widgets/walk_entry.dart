import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_client/src/models/diary.dart';
import 'package:mobile_client/src/models/walk_entry.dart';
import 'package:mobile_client/src/services/fetch_walk_entries.dart';
import 'package:mobile_client/src/services/fetch_diaries.dart';
import 'package:provider/provider.dart';

// 呼び出されるページクラス
class WalkEntryPage extends StatefulWidget {
  @override
  State<WalkEntryPage> createState() => _WalkEntryPageState();
}

// ページの内部処理
class _WalkEntryPageState extends State<WalkEntryPage> {
  List<WalkEntry> walkEntries = [];
  List<Diary> diaries = [];
  @override
  void initState() {
    super.initState();
    fetchDogAndSet();
    fetchDiaryAndSet();
  }

  Future fetchDogAndSet() async {
    try {
      var res = await fetchWalkEntries();
      if (res != null) {
        var parsed = json.decode(res) as List<dynamic>;
        setState(() {
          walkEntries = parsed.map((json) => WalkEntry.fromJson(json)).toList();
        });
      }
    } catch (e) {
      // Handle or log the error
      print(e);
    }
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
      // Handle or log the error
      print(e);
    }
  }

  Widget build(BuildContext context) {
    print(walkEntries);

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
          for (var diary in diaries) Text(diary.description),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text('散歩記録一覧'),
        ),
        ElevatedButton(onPressed: fetchDogAndSet, child: Text('取得する')),
        if (walkEntries.isEmpty)
          Text('散歩記録がありません')
        else
          for (var walkEntry in walkEntries) Text(walkEntry.id),
      ],
    );
  }
}
