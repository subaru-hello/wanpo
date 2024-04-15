import 'package:flutter/material.dart';
import 'package:mobile_client/src/api/walk_entry_api.dart';
import 'package:mobile_client/src/models/walk_entry.dart';
import 'package:mobile_client/src/widgets/walkEntry/walk_entry_container.dart';

// 呼び出されるページクラス
class WalkEntryPage extends StatefulWidget {
  final String diaryId;

  const WalkEntryPage({Key? key, required this.diaryId}) : super(key: key);

  @override
  State<WalkEntryPage> createState() => _WalkEntryPageState();
}

// ページの内部処理
class _WalkEntryPageState extends State<WalkEntryPage> {
  List<WalkEntry> walkEntries = [];
  // 初期化時に呼ぶ関数。useEffectのような？
  @override
  void initState() {
    super.initState();
    // DiaryIdに紐づくWalkEntryを全て取得
    fetchWalkEntriesAndSet(diaryId: widget.diaryId);
  }

// async/awaitはFuture型になる
  Future fetchWalkEntriesAndSet({required diaryId}) async {
    try {
      print("walk===entry");
      var res = await fetchWalkEntriesByDiaryId(diaryId: diaryId);
      print("======↓res↓====");
      print(res);
      if (res != null) {
        List<WalkEntry> parsedWalkEntries = res
            .map<WalkEntry>((walkEntry) => WalkEntry.fromJson(walkEntry))
            .toList();
        setState(() {
          walkEntries = parsedWalkEntries;
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
        if (walkEntries.isEmpty)
          Center(child: Text('散歩記録がありません'))
        else
          ...walkEntries
              .map((walkEntry) => WalkEntryContainer(walkEntry: walkEntry))
              .toList(),
      ],
    );
  }
}
