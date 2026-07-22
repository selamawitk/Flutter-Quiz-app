import 'package:dio/dio.dart';
import '../../../domain/forgot_password/entities/forgot_password.dart';
import '../../core/network/http_client.dart';

abstract class ForgotPasswordRemoteDataSource {
  Future<ForgotPassword> sendPasswordResetLink(String username);
  Future<bool> validateResetLink(String token);
  Future<ForgotPassword> getUserByUsername(String username);
}

class ForgotPasswordRemoteDataSourceImpl implements ForgotPasswordRemoteDataSource {
  final HttpClient _httpClient = HttpClient();

  @override
  Future<ForgotPassword> sendPasswordResetLink(String username) async {
    try {
      final response = await _httpClient.dio.get(
        '/auth/username-exists/$username',
      );

      if (response.statusCode == 200) {
        return ForgotPassword(
          username: username,
          resetToken: '',
          requestTime: DateTime.now(),
          isTokenValid: response.data['exists'] ?? false,
        );
      } else {
        throw Exception('User not found');
      }
    } on DioException catch (e) {
      throw Exception('Failed to send password reset link: ${e.message}');
    }
  }

  @override
  Future<bool> validateResetLink(String token) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/verify-security-answers',
        data: {'token': token},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to validate reset link: ${e.message}');
    }
  }

  @override
  Future<ForgotPassword> getUserByUsername(String username) async {
    try {
      final response = await _httpClient.dio.get(
        '/auth/username-exists/$username',
      );

      if (response.statusCode == 200) {
        return ForgotPassword(
          username: username,
          resetToken: '',
          requestTime: DateTime.now(),
          isTokenValid: response.data['exists'] ?? false,
        );
      } else {
        throw Exception('User not found');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('User not found');
      }
      throw Exception('Failed to get user: ${e.message}');
    }
  }
}
