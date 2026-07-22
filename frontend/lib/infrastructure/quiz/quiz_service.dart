import 'package:dio/dio.dart';
import '../core/network/http_client.dart';

class QuizService {
  final HttpClient _httpClient = HttpClient();

  Future<List<Map<String, dynamic>>> getAllQuizzes() async {
    try {
      final response = await _httpClient.dio.get('/quiz');

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['quizzes'] ?? []);
      } else {
        throw Exception('Failed to get quizzes');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get quizzes');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<Map<String, dynamic>> getQuizById(String id) async {
    try {
      final response = await _httpClient.dio.get('/quiz/$id');

      if (response.statusCode == 200) {
        return response.data['quiz'];
      } else {
        throw Exception('Failed to get quiz');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get quiz');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<Map<String, dynamic>> submitQuizAttempt(String quizId, Map<String, dynamic> attemptData) async {
    try {
      final response = await _httpClient.dio.post(
        '/quiz/$quizId',
        data: attemptData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to submit quiz attempt');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to submit quiz attempt');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<List<Map<String, dynamic>>> getUserQuizHistory() async {
    try {
      final response = await _httpClient.dio.get('/quiz');

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['quizzes'] ?? []);
      } else {
        throw Exception('Failed to get quiz history');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get quiz history');
      } else {
        throw Exception('Network error');
      }
    }
  }
}
