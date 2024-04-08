import 'package:mobile_client/constants/type.dart';

class DogBreed {
  String id;
  String name;
  String breedId;
  Country country;
  String? profileImagePath;

// constructer: インスタンス作成時に必ず初期化される値
  DogBreed(
      {required this.id,
      required this.name,
      required this.breedId,
      required this.country,
      this.profileImagePath});

  String get getId => id;
  String get getNickname => name;
  String get getBreedId => breedId;
  Country get getBirthArea => country;
  String? get getProfileImagePath => profileImagePath;

  factory DogBreed.fromJson(Map<String, dynamic> json) {
    return DogBreed(
        id: json['id'],
        name: json['name'],
        breedId: json['breedId'],
        country: json['country'],
        profileImagePath: json['profileImagePath']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'breedId': breedId,
      'country': country,
      'profileImagePath': profileImagePath,
    };
  }
}
