import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_client/src/models/session.dart';

import '../../constants/urls.dart';

Future fetchDogs() async {
  final httpPackageResponse = await http.get(dogUrl);
  if (httpPackageResponse.statusCode != HttpStatus.ok) {
    print('Failed to retrieve the http package!');
    return;
  }
  return httpPackageResponse.body;
}

Future fetchOwnedDogs(String cognitoSub) async {
  var headers = {
    'Content-Type': 'application/json',
    'Cookie': 'cognito-sub=$cognitoSub;'
  };
  final httpPackageResponse = await http.get(ownedDogUrl, headers: headers);
  if (httpPackageResponse.statusCode != HttpStatus.ok) {
    print('Failed to retrieve the http package!');
    return;
  }
  print(jsonDecode(httpPackageResponse.body));
  return jsonDecode(httpPackageResponse.body);
}

Future registerDog({
  required String nickname,
  required String breedId,
  required String cognitoSub,
  String? birthArea,
  DateTime? birthDate,
  String? dogOwnerProfileId,
  String? profileImagePath,
}) async {
  final session = Session();
  final body = json.encode({
    'nickname': nickname,
    'breedId': breedId,
    'cognitoSub': cognitoSub,
    'birthArea': birthArea,
    'birthDate': birthDate,
    'dogOwnerProfileId': dogOwnerProfileId,
    'profileImagePath': profileImagePath,
  });

  final response = await session.post(dogUrl, body);

  if (!response) {
    print('Failed to register the dog!');
    return;
  }
  return response; // 成功時にレスポンスを返す
}
