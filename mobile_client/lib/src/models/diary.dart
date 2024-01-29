class Diary {
  String id;
  String title;
  String description;
  String createdAt;
  String updatedAt;
  String? unregisterdAt;
  String dogId;

// constructer: インスタンス作成時に必ず初期化される値
  Diary({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.unregisterdAt,
    required this.dogId,
  });

  String get getId => id;
  String get getTitle => title;
  String get getDescription => description;
  String get getCreatedAt => createdAt;
  String get getUpdatedAt => updatedAt;
  String? get getUnregisterdAt => unregisterdAt;
  String get getDogId => dogId;

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        unregisterdAt: json['unregisterdAt'],
        dogId: json['dogId']);
  }
  // Method to convert a Diary instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'unregisterdAt': unregisterdAt,
      'dogId': dogId,
    };
  }
}
