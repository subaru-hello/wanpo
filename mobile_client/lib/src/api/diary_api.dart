import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_client/src/models/session.dart';
import 'package:mobile_client/src/utils/localstorageUtils.dart';

import '../../constants/urls.dart';

Future fetchDiaries() async {
  final httpPackageResponse = await http.get(diaryUrl);
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
  final token = await SecureTokenStorage.getStorageValue('jwtToken');
  final cookie = await SecureTokenStorage.getStorageValue('cookie');
  session.headers = {
    'Content-Type': 'application/json', // ヘッダーにContentTypeを指定
    HttpHeaders.authorizationHeader: 'Basic $token',
    'Cookie': cookie
  };
  // フロントで、初期ロード時にuserSubに紐づく犬の情報を取得しておく
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
