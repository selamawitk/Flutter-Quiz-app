import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../config.dart';

class HttpClient {
  static final HttpClient _instance = HttpClient._internal();
  late Dio dio;

  // Singleton pattern
  factory HttpClient() => _instance;

  HttpClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.apiBaseUrl,
        connectTimeout: Duration(seconds: AppConfig.connectionTimeout),
        receiveTimeout: Duration(seconds: AppConfig.receiveTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Add logging interceptor
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode) {
            print('REQUEST[${options.method}] => PATH: ${options.path}');
            print('HEADERS: ${options.headers}');
            print('DATA: ${options.data}');
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode) {
            print('RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
            print('DATA: ${response.data}');
          }
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          if (kDebugMode) {
            print('ERROR[${e.response?.statusCode}] => PATH: ${e.requestOptions.path}');
            print('MESSAGE: ${e.message}');
          }
          return handler.next(e);
        },
      ),
    );
  }

  // Add auth token to requests
  void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // Clear auth token
  void clearAuthToken() {
    dio.options.headers.remove('Authorization');
  }
} 