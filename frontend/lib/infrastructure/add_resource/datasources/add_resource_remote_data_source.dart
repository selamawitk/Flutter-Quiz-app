import 'package:dio/dio.dart';
import '../../core/network/http_client.dart';

abstract class AddResourceRemoteDataSource {
  Future<void> createResource({
    required String title,
    required String description,
    required String link,
  });
}

class AddResourceRemoteDataSourceImpl implements AddResourceRemoteDataSource {
  final HttpClient _httpClient = HttpClient();

  @override
  Future<void> createResource({
    required String title,
    required String description,
    required String link,
  }) async {
    try {
      final response = await _httpClient.dio.post(
        '/resources',
        data: {
          'title': title,
          'description': description,
          'url': link,
          'category': 'general',
          'type': 'document',
        },
      );

      if (response.statusCode != 201) {
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
}
