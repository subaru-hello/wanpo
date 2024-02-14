class Dog {
  String id;
  String nickname;
  String breedId;
  String birthArea;
  DateTime? birthDate;
  String? profileImagePath;

// constructer: インスタンス作成時に必ず初期化される値
  Dog(
      {required this.id,
      required this.nickname,
      required this.breedId,
      required this.birthArea,
      this.birthDate,
      this.profileImagePath});

  String get getId => id;
  String get getNickname => nickname;
  String get getBreedId => breedId;
  String get getBirthArea => birthArea;
  DateTime? get getBirthDate => birthDate;
  String? get getProfileImagePath => profileImagePath;

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
        id: json['id'],
        nickname: json['nickname'],
        breedId: json['breedId'],
        birthArea: json['birthArea'],
        birthDate: json['birthDate'],
        profileImagePath: json['profileImagePath']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'breedId': breedId,
      'birthArea': birthArea,
      'birthDate': birthDate,
      'profileImagePath': profileImagePath,
    };
  }
}
