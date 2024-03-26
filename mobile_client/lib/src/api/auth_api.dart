import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_client/src/utils/localstorageUtils.dart';

import '../../constants/urls.dart';

dynamic printAnything(dynamic printTarget, key) {
  print("====$key=====");
  print(printTarget);
  print("====$key=====");
}

Future<Map<String, String>> parseCookies(String cookieString) async {
  Map<String, String> cookies = {};
  final cookieParts = cookieString.split(';');

  for (var part in cookieParts) {
    final keyValue = part.split('=');
    printAnything(keyValue, "keyValue");
    if (keyValue.length == 2) {
      var key = keyValue.first;
      var value = keyValue.last;

      print('最初の要素: $key');
      print('最後の要素: $value');
      // 'Path' やその他の属性ではなく、指定されたクッキー名のみを探す
      if (key == 'Path' ||
          key == 'Expires' ||
          key == 'jwtToken' ||
          key == 'userSub' ||
          key == 'refreshToken') {
        cookies[key] = value;
        await SecureTokenStorage.saveToken(key, value);
        // printAnything(key);
        // printAnything(cookies[key], cookies[key]);
      }
    } else if (keyValue.length > 2) {
      var key = keyValue[keyValue.length - 2]; // 後ろから2番目の要素
      print('編集前の要素: $key');
      key = key.contains(",") ? key.split(",").last : key;
      var value = keyValue.last; // 最後の要素、またはmyList[myList.length - 1];

      print('後ろから2番目の要素: $key');
      print('最後の要素: $value');
      // 'Path' やその他の属性ではなく、指定されたクッキー名のみを探す
      if (key == 'Path' ||
          key == 'Expires' ||
          key == 'jwtToken' ||
          key == 'userSub' ||
          key == 'refreshToken') {
        await SecureTokenStorage.saveToken(key, value);
        // printAnything(key);
        // cookies[key] = value;
      }
    }
  }

  return cookies;
}

Future login({required String email, required String password}) async {
  const jwtTokenKey = 'jwtToken';
  const userSubKey = 'userSub';
  const refreshTokenKey = 'refreshToken';
  final response = await http.post(
    loginUrl,
    headers: <String, String>{
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'email': email,
      'password': password,
    }),
  );
  if (response.statusCode == HttpStatus.ok) {
    // "Set-Cookie"ヘッダーからCookieを取得
    String? cookie = response.headers['set-cookie'];
    if (cookie != null) {
      await parseCookies(cookie);
      final token = await SecureTokenStorage.getStorageValue(jwtTokenKey);
      final sub = await SecureTokenStorage.getStorageValue(userSubKey);
      final refresh = await SecureTokenStorage.getStorageValue(refreshTokenKey);
      final cookieHeader =
          'jwtToken=$token; refreshToken=$refresh; userSub=$sub';
      await SecureTokenStorage.saveToken('cookie', cookieHeader);
      print('response cookie');
      print('token $token');
      print('sub $sub');
      print('refresh $refresh');
    }
  } else {
    print('Failed to login');
    return false;
  }
}
