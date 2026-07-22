import 'package:dio/dio.dart';
import '../core/network/http_client.dart';

class AuthService {
  final HttpClient _httpClient = HttpClient();

  void setToken(String token) {
    _httpClient.setAuthToken(token);
  }

  Future<Map<String, dynamic>> login(String username, String password, String role) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/login',
        data: {
          'username': username,
          'password': password,
          'role': role,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        _httpClient.setAuthToken(token);
        return response.data;
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Login failed');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<Map<String, dynamic>> register(String username, String password, String role) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/register',
        data: {
          'username': username,
          'password': password,
          'role': role,
        },
      );

      if (response.statusCode == 201) {
        final token = response.data['token'];
        _httpClient.setAuthToken(token);
        return response.data;
      } else {
        throw Exception('Failed to register');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Registration failed');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<bool> checkUsernameExists(String username) async {
    try {
      final response = await _httpClient.dio.get('/auth/username-exists/$username');

      if (response.statusCode == 200) {
        return response.data['exists'] ?? false;
      } else {
        throw Exception('Failed to check username');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to check username');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<Map<String, String>> getSecurityQuestions(String username) async {
    try {
      final response = await _httpClient.dio.get('/auth/security-questions/$username');

      if (response.statusCode == 200) {
        return Map<String, String>.from(response.data['questions']);
      } else {
        throw Exception('Failed to get security questions');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get security questions');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<String> verifySecurityAnswers(String username, Map<String, String> answers) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/verify-security-answers',
        data: {
          'username': username,
          'providedAnswers': answers,
        },
      );

      if (response.statusCode == 200) {
        return response.data['resetToken'] ?? '';
      } else {
        throw Exception('Failed to verify security answers');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to verify security answers');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<bool> resetPassword(String username, String newPassword, String resetToken) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/reset-password',
        data: {
          'username': username,
          'newPassword': newPassword,
          'resetToken': resetToken,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to reset password');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<bool> setSecurityQuestions(String username, Map<String, dynamic> securityQuestions) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/security-questions',
        data: {
          'username': username,
          'securityQuestions': securityQuestions,
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to set security questions');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await _httpClient.dio.get('/auth/me');

      if (response.statusCode == 200) {
        return response.data['user'];
      } else {
        throw Exception('Failed to get user data');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get user data');
      } else {
        throw Exception('Network error');
      }
    }
  }

  void logout() {
    _httpClient.clearAuthToken();
  }
}
