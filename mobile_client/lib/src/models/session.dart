import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mobile_client/src/utils/localstorageUtils.dart';

class Session {
  Map<String, String> headers = {'Content-Type': 'application/json'};

  Future get(Uri url) async {
    final cookie = await SecureTokenStorage.getStorageValue('cookie');
    print('=========$cookie');
    headers = {
      'Content-Type': 'application/json', // ヘッダーにContentTypeを指定
      'Cookie': cookie
    };
    try {
      http.Response response = await http.get(url, headers: headers);
      return response.body;
    } catch (e) {
      print(e);
    }
  }

  Future post(Uri url, dynamic body) async {
    final token = await SecureTokenStorage.getStorageValue('jwtToken');
    final cookie = await SecureTokenStorage.getStorageValue('cookie');
    print('=========$cookie');
    headers = {
      'Content-Type': 'application/json', // ヘッダーにContentTypeを指定
      HttpHeaders.authorizationHeader: 'Basic $token',
      'Cookie': cookie
    };
    try {
      http.Response response =
          await http.post(url, body: body, headers: headers);
      print('login info $response');
      // updateCookie(response);
      // return response;
      print('Response body: ${response.body}');
      return response;
    } catch (e) {
      print("error");
      print(e);
      // Error();
    }
  }

  void updateCookie(http.Response response) {
    String? rawCookie = response.headers['set-cookie'];
    if (rawCookie != null) {
      int index = rawCookie.indexOf(';');
      headers['cookie'] =
          (index == -1) ? rawCookie : rawCookie.substring(0, index);
    }
  }
}
