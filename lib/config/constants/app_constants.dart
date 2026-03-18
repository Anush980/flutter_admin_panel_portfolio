import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  
  // private constructor
  AppConstants._();

  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static const String baseVersion = 'v1';
  static const int connectTimeout = 10000;
  static const int receiveTimeout = 10000;
  static const String tokenKey = 'auth_token';
  static const String userKey = 'auth_user';
}
