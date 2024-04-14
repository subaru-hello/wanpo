import 'dart:convert';
import 'dart:io';

import 'package:mobile_client/src/models/session.dart';
import 'package:mobile_client/src/utils/encode.dart';
import 'package:mobile_client/src/utils/local_storage_utils.dart';

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

  final body = json.encode({
    'title': title,
    'description': description,
    'diaryId': diaryId,
    'stepCount': stepCount,
    'date': encodeDateTimeToString(date),
    'duration': duration,
    'summaryImagePath': summaryImagePath ?? ""
  });
  print("======");
  print(body);
  print(walkEntryUrl);
  print("======");

  final response = await session.post(walkEntryUrl, body);

  if (!response) {
    print(response);
    print('Failed to post the walkEntry!');
    return;
  }
  return response; // 成功時にレスポンスを返す
}
