class WalkEntry {
  String id;
  String date;
  int stepCount;
  int duration;
  String diaryId;
  String createdAt;
  String updatedAt;
  String? unregisterdAt;

  WalkEntry({
    required this.id,
    required this.date,
    required this.stepCount,
    required this.duration,
    required this.diaryId,
    required this.createdAt,
    required this.updatedAt,
    this.unregisterdAt,
  });

  // Getter for createdAt
  String get getCreatedAt => createdAt;

  // Getter for duration
  int get getDuration => duration;

  // A method to create a WalkEntry from a Map (i.e., JSON object)
  factory WalkEntry.fromJson(Map<String, dynamic> json) {
    return WalkEntry(
      id: json['id'],
      date: json['date'],
      stepCount: json['stepCount'],
      duration: json['duration'],
      diaryId: json['diaryId'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      unregisterdAt: json['unregisterdAt'],
    );
  }

  // A method to convert a WalkEntry instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'stepCount': stepCount,
      'duration': duration,
      'diaryId': diaryId,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'unregisterdAt': unregisterdAt,
    };
  }
}
