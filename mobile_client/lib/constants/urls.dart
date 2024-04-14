import 'package:flutter_dotenv/flutter_dotenv.dart';

final apiUrl = dotenv.env['API_URL'];
final isLocal = dotenv.env['ENV'] == "development";
String checkEnv(bool isLocal, String path) {
  return isLocal ? "/$path" : "/production/$path";
}

Uri buildUri(String path) {
  // 環境に応じてパスを調整
  final adjustedPath = checkEnv(isLocal, path);
  // ローカル開発環境ではhttp、本番環境ではhttpsを使用
  return isLocal
      ? Uri.http(apiUrl!, adjustedPath)
      : Uri.https(apiUrl!, adjustedPath);
}

Uri getWalkEntryUrl(String? diaryId) {
  return diaryId != null
      ? buildUri('walk-entries/$diaryId')
      : buildUri("walk-entries");
}

// 関数を呼び出して結果を変数に格納
final Uri walkEntryUrl = buildUri("walk-entries");
final Uri diaryUrl = buildUri("diaries");
final Uri loginUrl = buildUri("auth/login");
final Uri refreshAccessTokenUrl = buildUri("auth/refresh-access-token");
final Uri checkLoggedInUrl = buildUri("auth/is-logged-in");
final Uri dogUrl = buildUri("dogs");
final Uri dogBreedUrl = buildUri("dog-breeds");
final Uri ownedDogUrl = buildUri("dogs/owned-dogs");
