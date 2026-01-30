import 'package:dio/dio.dart';

class ApiClient {
  late Dio _dio;

  // Android Emulator uses 10.0.2.2 to access localhost
  // iOS Simulator uses localhost
  static const String _baseUrl = 'http://10.0.2.2:8080/api';

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 5),
        receiveTimeout: const Duration(seconds: 3),
      ),
    );

    // Add logging to see what's happening
    _dio.interceptors.add(
      LogInterceptor(responseBody: true, requestBody: true),
    );
  }

  // Generic GET
  Future<Response> get(String path) async {
    try {
      return await _dio.get(path);
    } catch (e) {
      throw _handleError(e);
    }
  }

  // Generic POST
  Future<Response> post(String path, dynamic data) async {
    try {
      return await _dio.post(path, data: data);
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    return Exception("Network Error: $error");
  }
}
