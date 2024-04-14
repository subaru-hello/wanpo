import 'package:http/http.dart' as http;

import '../../constants/urls.dart';

Future fetchDogBreeds() async {
  final httpPackageResponse = await http.get(dogBreedUrl);
  print(httpPackageResponse.statusCode);
  print(httpPackageResponse.body);
  if (httpPackageResponse.statusCode != 200) {
    print('Failed to retrieve the http package!');
    return;
  }
  return httpPackageResponse.body;
}
