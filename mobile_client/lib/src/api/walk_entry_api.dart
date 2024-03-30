import 'dart:convert';
import 'dart:io';

import 'package:mobile_client/src/models/session.dart';
import 'package:mobile_client/src/models/walk_entry.dart';
import 'package:mobile_client/src/utils/localstorageUtils.dart';

import '../../constants/urls.dart';

Future fetchWalkEntriesByDiaryId({required diaryId}) async {
  final session = Session();
  final httpPackageResponse = await session.get(getWalkEntryUrl(diaryId));
  if (httpPackageResponse == null) {
    print('Failed to retrieve the http package!');
    return;
  }
  return json.decode(httpPackageResponse);
}

Future registerWalkEntry({
  required String title,
  required String diaryId,
  required DateTime date,
  String? description,
  int? stepCount,
  int? duration,
  String? summaryImagePath,
}) async {
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
    'diaryId': diaryId,
    'stepCount': stepCount,
    'date': date,
    'duration': duration,
    'summaryImagePath': summaryImagePath
  });

  final response = await session.post(walkEntryUrl, body);

  if (!response) {
    print('Failed to post the walkEntry!');
    return;
  }
  return response; // 成功時にレスポンスを返す
}
