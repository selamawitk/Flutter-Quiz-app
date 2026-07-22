import 'package:dio/dio.dart';
import '../../../domain/reset_password/entities/reset_password.dart';
import '../../core/network/http_client.dart';

abstract class ResetPasswordRemoteDataSource {
  Future<bool> resetPassword(ResetPassword resetPassword);
  Future<bool> validateResetToken(String token);
  Future<String> generateResetToken(String username);
}

class ResetPasswordRemoteDataSourceImpl implements ResetPasswordRemoteDataSource {
  final HttpClient _httpClient = HttpClient();

  @override
  Future<bool> resetPassword(ResetPassword resetPassword) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/reset-password',
        data: resetPassword.toJson(),
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to reset password: ${e.message}');
    }
  }

  @override
  Future<bool> validateResetToken(String token) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/verify-security-answers',
        data: {'token': token},
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to validate reset token: ${e.message}');
    }
  }

  @override
  Future<String> generateResetToken(String username) async {
    try {
      final response = await _httpClient.dio.get(
        '/auth/security-questions/$username',
      );

      if (response.statusCode == 200) {
        return response.data['token'] ?? '';
      } else {
        throw Exception('Failed to generate reset token');
      }
    } on DioException catch (e) {
      throw Exception('Failed to generate reset token: ${e.message}');
    }
  }
}
