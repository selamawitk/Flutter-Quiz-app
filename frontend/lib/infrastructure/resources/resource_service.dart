import 'package:dio/dio.dart';
import '../core/network/http_client.dart';

class ResourceService {
  final HttpClient _httpClient = HttpClient();

  Future<List<Map<String, dynamic>>> getAllResources() async {
    try {
      final response = await _httpClient.dio.get('/resources');

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(response.data['resources']);
      } else {
        throw Exception('Failed to get resources');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get resources');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<Map<String, dynamic>> getResourceById(String id) async {
    try {
      final response = await _httpClient.dio.get('/resources/$id');

      if (response.statusCode == 200) {
        return response.data['resource'];
      } else {
        throw Exception('Failed to get resource');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to get resource');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<List<String>> getResourceCategories() async {
    try {
      final response = await _httpClient.dio.get('/resources/categories');

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

  Future<Map<String, dynamic>> createResource(Map<String, dynamic> resourceData) async {
    try {
      final response = await _httpClient.dio.post(
        '/resources',
        data: resourceData,
      );

      if (response.statusCode == 201) {
        return response.data;
      } else {
        throw Exception('Failed to create resource');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to create resource');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<Map<String, dynamic>> updateResource(String id, Map<String, dynamic> resourceData) async {
    try {
      final response = await _httpClient.dio.put(
        '/resources/$id',
        data: resourceData,
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to update resource');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to update resource');
      } else {
        throw Exception('Network error');
      }
    }
  }

  Future<bool> deleteResource(String id) async {
    try {
      final response = await _httpClient.dio.delete('/resources/$id');

      return response.statusCode == 200;
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to delete resource');
      } else {
        throw Exception('Network error');
      }
    }
  }
}
