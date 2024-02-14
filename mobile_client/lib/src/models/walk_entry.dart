import 'package:mobile_client/src/models/diary.dart';
import 'package:mobile_client/src/models/excrement.dart';

class WalkEntry {
  String id;
  String date;
  String title;
  int stepCount;
  int duration;
  String? summaryImagePath;
  String diaryId;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? unregisterdAt;
  Diary diary;
  List<Excrement> excrements;

  WalkEntry(
      {required this.id,
      required this.date,
      required this.stepCount,
      required this.title,
      required this.duration,
      required this.diaryId,
      required this.createdAt,
      required this.updatedAt,
      required this.excrements,
      this.unregisterdAt,
      this.summaryImagePath,
      required this.diary});

  DateTime get getCreatedAt => createdAt;
  String? get getSummaryImagePath => summaryImagePath;

  int get getDuration => duration;

  factory WalkEntry.fromJson(Map<String, dynamic> json) {
    return WalkEntry(
      id: json['id'] ?? '',
      date: json['date'] ?? '',
      stepCount: json['stepCount'] ?? 0,
      duration: json['duration'] ?? 0,
      title: json['title'] ?? '',
      summaryImagePath: json['summaryImagePath'],
      excrements: (json['excrements'] as List<dynamic>?)
              ?.map((e) => Excrement.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      diaryId: json['diaryId'] ?? '',
      diary: json['diary'] != null
          ? Diary.fromJson(json['diary'] as Map<String, dynamic>)
          : Diary.defaultDiary(), // 初期値を設定
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      unregisterdAt: json['unregisterdAt'] != null
          ? DateTime.parse(json['unregisterdAt'])
          : null,
    );
  }

  //  WalkEntryインスタンスをMapに変換
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'stepCount': stepCount,
      'duration': duration,
      'title': title,
      'excrements': excrements,
      'summaryImagePath': summaryImagePath,
      'diaryId': diaryId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'unregisterdAt': unregisterdAt,
    };
  }
}
