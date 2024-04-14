import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile_client/src/models/session.dart';

import '../../constants/urls.dart';

Future fetchDiaries() async {
  final httpPackageResponse = await http.get(diaryUrl);
  if (httpPackageResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  return httpPackageResponse.body;
}

Future fetchDiary({required diaryId}) async {
  final session = Session();
  final body = json.encode({'diaryId': diaryId});
  final httpPackageResponse = await session.post(diaryUrl, body);
  if (httpPackageResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  return httpPackageResponse.body;
}

Future registerDiary(
    {required String title,
    required String description,
    required String dogId,
    String? coverImagePath}) async {
  final session = Session();
  // フロントで、初期ロード時にcognitoSubに紐づく犬の情報を取得しておく
  final body = json.encode({
    'title': title,
    'description': description,
    'dogId': dogId,
    'coverImagePath': coverImagePath
  });

  final response = await session.post(diaryUrl, body);

  if (!response) {
    print('Failed to post the diary!');
    return;
  }
  return response; // 成功時にレスポンスを返す
}
