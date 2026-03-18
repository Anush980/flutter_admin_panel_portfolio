import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../config/constants/app_constants.dart';

class SecureStorage {
  SecureStorage._();

  static const _storage = FlutterSecureStorage();

  static Future<void> saveToken(String token) async {
    await _storage.write(key: AppConstants.tokenKey, value: token);
  }

  static Future<String?> getToken() async {
    return _storage.read(key: AppConstants.tokenKey);
  }

  static Future<void> deleteToken() async {
    await _storage.delete(key: AppConstants.tokenKey);
  }

  static Future<void> clearAll() async {
    await _storage.deleteAll();
  }
}