import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureTokenStorage {
  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String key, String token) async {
    await _storage.write(key: key, value: token);
  }

  static Future<String> getStorageValue(key) async {
    return await _storage.read(key: key) ?? "";
  }

  static Future<void> clearToken() async {
    await _storage.delete(key: 'jwtToken');
  }
}
