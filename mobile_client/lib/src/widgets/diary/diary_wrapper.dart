import 'package:flutter/material.dart';
import 'package:mobile_client/src/models/diary.dart';
import 'package:mobile_client/src/widgets/image_from_s3.dart';

class DiaryComponent extends StatelessWidget {
  final Diary diary;
  final Function(Diary) onTap;

  DiaryComponent({required this.diary, required this.onTap});
  String formatDate(DateTime date) {
    String year = date.year.toString();
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(diary);
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0), // 項目間にマージンを追加
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.blueGrey, // 背景色を設定
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start, // タイトルと説明を左揃え
          children: [
            Text(
              diary.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            SizedBox(
              height: 200,
              child: ImageFromS3(
                  imagePath: diary.coverImagePath ?? "default-dog-img.png"),
            ),
            SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(diary.description),
                ),
                Text(
                  formatDate(DateTime.parse(diary.createdAt)),
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
