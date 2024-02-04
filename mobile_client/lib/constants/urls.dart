import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final apiUrl = dotenv.env['API_URL'];
final walkEntryUrl = Uri.https(apiUrl!, "/production/walk-entries");
final diaryUrl = Uri.https(apiUrl!, "/production/diaries");
final dogUrl = Uri.https(apiUrl!, "/production/dogs");
