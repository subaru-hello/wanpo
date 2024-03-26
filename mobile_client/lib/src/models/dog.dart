class Dog {
  String id;
  String nickname;
  String breedId;
  String birthArea;
  String ownerId;
  String? dogOwnerProfileId;
  DateTime? birthDate;
  String? profileImagePath;

// constructer: インスタンス作成時に必ず初期化される値
  Dog(
      {required this.id,
      required this.nickname,
      required this.breedId,
      required this.birthArea,
      required this.ownerId,
      this.dogOwnerProfileId,
      this.birthDate,
      this.profileImagePath});

  String get getId => id;
  String get getNickname => nickname;
  String get getBreedId => breedId;
  String get getBirthArea => birthArea;
  String get getOwnerId => ownerId;
  String? get getOwnerProfileId => dogOwnerProfileId;
  DateTime? get getBirthDate => birthDate;
  String? get getProfileImagePath => profileImagePath;

  factory Dog.fromJson(Map<String, dynamic> json) {
    return Dog(
        id: json['id'],
        nickname: json['nickname'],
        breedId: json['breedId'],
        birthArea: json['birthArea'],
        birthDate: json['birthDate'],
        ownerId: json['ownerId'],
        dogOwnerProfileId: json['dogOwnerProfileId'],
        profileImagePath: json['profileImagePath']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nickname': nickname,
      'breedId': breedId,
      'birthArea': birthArea,
      'birthDate': birthDate,
      'ownerId': ownerId,
      'dogOwnerProfileId': dogOwnerProfileId,
      'profileImagePath': profileImagePath,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dog && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
