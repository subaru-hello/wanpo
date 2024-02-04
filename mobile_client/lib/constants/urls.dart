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

// 関数を呼び出して結果を変数に格納
final Uri walkEntryUrl = buildUri("walk-entries");
final Uri diaryUrl = buildUri("diaries");
final Uri dogUrl = buildUri("dogs");
