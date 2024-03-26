import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import '../../constants/urls.dart';

Future fetchDogs() async {
  final httpPackageResponse = await http.get(dogUrl);
  if (httpPackageResponse.statusCode != HttpStatus.ok) {
    print('Failed to retrieve the http package!');
    return;
  }
  return httpPackageResponse.body;
}

Future fetchOwnedDogs(String cognitoSub) async {
  var headers = {
    'Content-Type': 'application/json',
    'Cookie': 'cognito-sub=$cognitoSub;'
  };
  final httpPackageResponse = await http.get(ownedDogUrl, headers: headers);
  if (httpPackageResponse.statusCode != HttpStatus.ok) {
    print('Failed to retrieve the http package!');
    return;
  }
  print(jsonDecode(httpPackageResponse.body));
  return jsonDecode(httpPackageResponse.body);
}
