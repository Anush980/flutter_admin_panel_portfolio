import 'package:dio/dio.dart';
import '../../config/constants/app_constants.dart';
import '../storage/secure_storage.dart';


class DioClient {

    //private constructor
  DioClient._();

  static Dio? _instance;

  static Dio get instance {
    //if instance is null then assign the result of '_createDio()'
    _instance ??= _createDio();
    //! at last promises that it is not null
    return _instance!;
  }

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConstants.connectTimeout),
        receiveTimeout: const Duration(milliseconds: AppConstants.receiveTimeout),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.addAll([
      _AuthInterceptor(),
      _ErrorInterceptor(),
      LogInterceptor(
        request: false,
        responseBody: true,
        error: true,
      ),
    ]);

    return dio;
  }
}

// Automatically attaches Bearer token to every request
class _AuthInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.getToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}

// Converts Dio errors into readable AppExceptions
class _ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final response = err.response;

    if (response != null) {
      final data = response.data;
      String message = 'Something went wrong';

      if (data is Map<String, dynamic>) {
        message = data['message'] ?? message;
        // If there are field errors, join them
        if (data['errors'] != null) {
          final errors = List<String>.from(data['errors']);
          message = errors.join('\n');
        }
      }

      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          response: err.response,
          error: AppException(
            message: message,
            statusCode: response.statusCode,
          ),
        ),
      );
    } else {
      handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: AppException(
            message: 'No internet connection or server unreachable.',
          ),
        ),
      );
    }
  }
}

class AppException implements Exception {
  final String message;
  final int? statusCode;

  const AppException({required this.message, this.statusCode});

  @override
  String toString() => message;
}