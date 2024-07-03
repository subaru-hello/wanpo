import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_client/src/utils/local_storage_utils.dart';

import '../../constants/urls.dart';

const jwtTokenKey = 'jwtToken';
const cognitoSubKey = 'cognitoSub';
const refreshTokenKey = 'refreshToken';

Future<Map<String, String>> parseCookies(String cookieString) async {
  Map<String, String> cookies = {};
  final cookieParts = cookieString.split(';');

  for (var part in cookieParts) {
    final keyValue = part.split('=');
    if (keyValue.length == 2) {
      var key = keyValue.first;
      var value = keyValue.last;

      print('最初の要素: $key');
      print('最後の要素: $value');
      // 'Path' やその他の属性ではなく、指定されたクッキー名のみを探す
      if (key == 'Path' ||
          key == 'Expires' ||
          key == 'jwtToken' ||
          key == 'cognitoSub' ||
          key == 'refreshToken') {
        cookies[key] = value;
        await SecureTokenStorage.saveToken(key, value);
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
          key == 'cognitoSub' ||
          key == 'refreshToken') {
        await SecureTokenStorage.saveToken(key, value);
      }
    }
  }

  return cookies;
}

Future login({required String email, required String password}) async {
  final response = await http.post(
    loginUrl,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Cookie': 'test=test;'
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
      final cookieHeader = await getCookieHeaderFromLStorage();
      await SecureTokenStorage.saveToken('cookie', cookieHeader);
    }
    return true;
  } else {
    print('Failed to login');
    return false;
  }
}

Future signUp({required String email, required String password}) async {
  final response = await http.post(
    loginUrl,
    headers: <String, String>{
      'Content-Type': 'application/json',
      // 'Cookie': 'test=test;'
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
      final cookieHeader = await getCookieHeaderFromLStorage();
      await SecureTokenStorage.saveToken('cookie', cookieHeader);
    }
    return true;
  } else {
    print('Failed to Sign Up');
    return false;
  }
}

Future verifyCode({required int verifyCode}) async {
  final jwt = await SecureTokenStorage.getStorageValue(jwtTokenKey);
  final response = await http.post(
    loginUrl,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Cookie': '$jwtTokenKey=$jwt'
    },
    body: json.encode({
      'verifyCode': verifyCode,
    }),
  );
  if (response.statusCode == HttpStatus.ok) {
    // "Set-Cookie"ヘッダーからCookieを取得
    String? cookie = response.headers['set-cookie'];
    if (cookie != null) {
      await parseCookies(cookie);
      final cookieHeader = await getCookieHeaderFromLStorage();
      await SecureTokenStorage.saveToken('cookie', cookieHeader);
    }
    return true;
  } else {
    print('Failed to verify code');
    return false;
  }
}

Future isLoggedIn() async {
  // refreshTokenでアクセスをリフレッシュする
  await refreshAccessToken();
  final hasCurrentLoggedIn = await checkCurrentLogin();
  if (!hasCurrentLoggedIn) {
    print("LOGIN_REQUIRED");
    return false;
  }

  return true;
}

Future refreshAccessToken() async {
  final sub = await SecureTokenStorage.getStorageValue(cognitoSubKey);
  final refreshToken =
      await SecureTokenStorage.getStorageValue(refreshTokenKey);
  final response = await http.get(
    refreshAccessTokenUrl,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Cookie': '$refreshTokenKey=$refreshToken;$cognitoSubKey=$sub;'
    },
  );
  print(response.statusCode);
  if (response.statusCode == HttpStatus.ok) {
    // "Set-Cookie"ヘッダーからCookieを取得
    String? cookie = response.headers['set-cookie'];
    if (cookie != null) {
      await parseCookies(cookie);
      final cookieHeader = await getCookieHeaderFromLStorage();
      await SecureTokenStorage.saveToken('cookie', cookieHeader);
      print('response cookie');
    }
    return true;
  } else {
    print('Failed to refreshToken access token');
    return false;
  }
}

Future checkCurrentLogin() async {
  final cookieHeader = await getCookieHeaderFromLStorage();
  await SecureTokenStorage.saveToken('cookie', cookieHeader);
  final response = await http.get(
    checkLoggedInUrl,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Cookie': cookieHeader
    },
  );
  if (response.statusCode != HttpStatus.ok) {
    return false;
  } else {
    return true;
  }
}

Future logout() async {
  final cookieHeader = await getCookieHeaderFromLStorage();
  final response = await http.post(
    logoutUrl,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Cookie': cookieHeader
    },
  );

  if (response.statusCode != HttpStatus.ok) {
    return false;
  } else {
    print("logout success");
    await clearAllLoginTokenFromLStorage();
    return true;
  }
}

Future clearAllLoginTokenFromLStorage() async {
  await SecureTokenStorage.clearToken(cognitoSubKey);
  await SecureTokenStorage.clearToken(jwtTokenKey);
  await SecureTokenStorage.clearToken(refreshTokenKey);
}

Future<String> getCookieHeaderFromLStorage() async {
  final token = await SecureTokenStorage.getStorageValue(jwtTokenKey);
  final sub = await SecureTokenStorage.getStorageValue(cognitoSubKey);
  final refreshToken =
      await SecureTokenStorage.getStorageValue(refreshTokenKey);
  final cookieHeader =
      'jwtToken=$token; refreshToken=$refreshToken; cognitoSub=$sub';
  print('response cookie');
  print('token $token');
  print('sub $sub');
  print('refreshToken $refreshToken');

  return cookieHeader;
}
