import 'package:dio/dio.dart';
import '../../../domain/signup/repositories/signup_repository.dart';
import '../../../domain/signup/entities/signup_entity.dart';
import '../../core/network/http_client.dart';

class SignupRepositoryImpl implements SignupRepository {
  final HttpClient _httpClient = HttpClient();

  @override
  Future<void> signup(SignupData data) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/register',
        data: {
          'username': data.username,
          'password': data.password,
          'role': 'student',
        },
      );

      if (response.statusCode != 201) {
        throw Exception('Signup failed');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Signup failed');
      } else {
        throw Exception('Network error');
      }
    }
  }
}
