import 'package:dio/dio.dart';
import '../core/network/http_client.dart';

class QuizService {
  final HttpClient _httpClient = HttpClient();

  // Get all quizzes
  Future<List<Map<String, dynamic>>> getAllQuizzes() async {
    try {
      final response = await _httpClient.dio.get('/quiz');
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['quizzes']);
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

  // Get quiz by ID
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

  // Get quiz categories
  Future<List<String>> getQuizCategories() async {
    try {
      final response = await _httpClient.dio.get('/quiz/categories');
      
      if (response.statusCode == 200) {
        return List<String>.from(response.data['categories']);
      } else {
        throw Exception('Failed to get categories');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get categories');
      } else {
        throw Exception('Network error');
      }
    }
  }

  // Create quiz (admin only)
  Future<Map<String, dynamic>> createQuiz(Map<String, dynamic> quizData) async {
    try {
      final response = await _httpClient.dio.post(
        '/quiz',
        data: quizData,
      );
      
      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create quiz');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to create quiz');
      } else {
        throw Exception('Network error');
      }
    }
  }

  // Update quiz (admin only)
  Future<Map<String, dynamic>> updateQuiz(String id, Map<String, dynamic> quizData) async {
    try {
      final response = await _httpClient.dio.put(
        '/quiz/$id',
        data: quizData,
      );
      
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update quiz');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to update quiz');
      } else {
        throw Exception('Network error');
      }
    }
  }

  // Delete quiz (admin only)
  Future<bool> deleteQuiz(String id) async {
    try {
      final response = await _httpClient.dio.delete('/quiz/$id');
      
      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to delete quiz');
      } else {
        throw Exception('Network error');
      }
    }
  }
} 