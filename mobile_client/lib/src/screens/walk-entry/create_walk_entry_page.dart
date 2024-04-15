import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_client/src/api/walk_entry_api.dart';
import 'package:mobile_client/src/models/diary.dart';
import 'package:mobile_client/src/widgets/walkEntry/walk_entry_form.dart';

class WalkEntryCreatePage extends StatefulWidget {
  final Diary selectedDiary;

  const WalkEntryCreatePage({Key? key, required this.selectedDiary})
      : super(key: key);

  @override
  State<WalkEntryCreatePage> createState() => _WalkEntryCreateState();
}

class _WalkEntryCreateState extends State<WalkEntryCreatePage> {
  String title = "";
  String summaryImagePath = "";
  DateTime date = DateTime.now();
  int? stepCount;
  int? duration;
  String? description;
  final storage = FlutterSecureStorage();
  late Future<String> cognitoSub;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    print(widget.selectedDiary);
  }

  void _handleStepCountsaved(int value) {
    setState(() {
      stepCount = value;
    });
  }

  void _handleDurationSaved(int value) {
    setState(() {
      duration = value;
    });
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

  // void _handleSummaryImagePathSaved(String value) {
  //   setState(() {
  //     summaryImagePath = value;
  //   });
  // }

  void _handleDateSaved(DateTime value) {
    setState(() {
      date = value;
    });
  }

  // アップロードする写真データを取得
  // アップロード先の写真パスを取得
  // 写真パスを取得

// WalkEntryを作成する
  Future _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // ここでregisterWalkEntry関数を呼び出す
      await registerWalkEntry(
              title: title,
              date: date,
              description: description,
              summaryImagePath: summaryImagePath,
              stepCount: stepCount,
              diaryId: widget.selectedDiary.id)
          .then((result) {
        // 成功した場合の処理
        print('WalkEntry registered successfully $stepCount $description');
      }).catchError((error) {
        // エラー処理
        print('Failed to register WalkEntry: $error');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('日記を作成')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            WalkEntryForm(
              formKey: _formKey,
              onTitleSaved: _handleTitleSaved,
              onDeacriptionSaved: _handleDeacriptionSaved,
              onDateSaved: _handleDateSaved,
              onDurationSaved: _handleDurationSaved,
              onStepCountSaved: _handleStepCountsaved,
              onSummaryImagePathSaved: _handleDeacriptionSaved,
              onSubmitForm: _submitForm,
            ),
            // タイトルの表示（デバッグ用）
            Text('タイトル: $title'),
            Text('歩数: $stepCount'),
            Text('説明書き: $description'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('対象の日記: '),
                Text(widget.selectedDiary.title),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
