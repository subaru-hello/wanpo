import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final apiUrl = dotenv.env['API_URL'];
final walkEntryUrl = Uri.https(apiUrl!, "/dev/walk-entries");
final diaryUrl = Uri.https(apiUrl!, "/dev/diaries");
final dogUrl = Uri.https(apiUrl!, "/dev/dogs");
