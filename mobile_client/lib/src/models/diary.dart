class Diary {
  String id;
  String title;
  String description;
  String? coverImagePath;
  String createdAt;
  String updatedAt;
  String? unregisterdAt;
  String dogId;

// constructer: インスタンス作成時に必ず初期化される値
  Diary({
    required this.id,
    required this.title,
    required this.description,
    required this.coverImagePath,
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
  String? get getCoverImagePath => coverImagePath;
  String? get getUnregisterdAt => unregisterdAt;
  String get getDogId => dogId;

  factory Diary.fromJson(Map<String, dynamic> json) {
    return Diary(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        coverImagePath: json['coverImagePath'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        unregisterdAt: json['unregisterdAt'],
        dogId: json['dogId']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'coverImagePath': coverImagePath,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'unregisterdAt': unregisterdAt,
      'dogId': dogId,
    };
  }

  static Diary defaultDiary() {
    return Diary(
      id: 'abafafbaf',
      /* default values for other fields */
      title: 'default title',
      /* default values for other fields */
      description: 'default description',
      /* default values for other fields */
      coverImagePath: 'default coverImagePath',
      /* default values for other fields */
      createdAt: 'default createdAt',
      /* default values for other fields */
      updatedAt: 'default updatedAt',
      /* default values for other fields */
      dogId: 'defaultdogId', /* default values for other fields */
    );
  }
}
