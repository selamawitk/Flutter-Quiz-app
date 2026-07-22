import 'package:dio/dio.dart';
import '../core/network/http_client.dart';

class CategoryService {
  final HttpClient _httpClient = HttpClient();

  // Get all quiz categories
  Future<List<String>> getAllCategories() async {
    try {
      final response = await _httpClient.dio.get('/quiz/categories');
      
      if (response.statusCode == 200) {
        return List<String>.from(response.data['categories'] ?? []);
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

  // Get quizzes by category
  Future<List<Map<String, dynamic>>> getQuizzesByCategory(String category) async {
    try {
      final response = await _httpClient.dio.get('/quiz', queryParameters: {'category': category});
      
      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['quizzes'] ?? []);
      } else {
        throw Exception('Failed to get quizzes for category');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get quizzes for category');
      } else {
        throw Exception('Network error');
      }
    }
  }
}
