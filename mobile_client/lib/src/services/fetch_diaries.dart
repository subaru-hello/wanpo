import 'package:http/http.dart' as http;

import '../../constants/urls.dart';

Future fetchDiaries() async {
  final httpPackageResponse = await http.get(diaryUrl);
  if (httpPackageResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  return httpPackageResponse.body;
}
