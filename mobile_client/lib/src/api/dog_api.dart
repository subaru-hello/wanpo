import 'package:http/http.dart' as http;

import '../../constants/urls.dart';

Future fetchDogs() async {
  final httpPackageResponse = await http.get(dogUrl);
  if (httpPackageResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  return httpPackageResponse.body;
}
