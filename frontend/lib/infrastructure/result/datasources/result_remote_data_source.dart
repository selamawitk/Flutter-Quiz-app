import 'package:dio/dio.dart';
import '../../../domain/result/entities/result.dart';
import '../../core/network/http_client.dart';

abstract class ResultRemoteDataSource {
  Future<List<Result>> fetchResults();
}

class ResultRemoteDataSourceImpl implements ResultRemoteDataSource {
  final HttpClient _httpClient = HttpClient();

  @override
  Future<List<Result>> fetchResults() async {
    try {
      final response = await _httpClient.dio.get('/quiz');

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['quizzes'] ?? [];
        return data.map((json) => Result(
          id: json['_id'] ?? json['id'] ?? '',
          title: json['title'] ?? '',
          score: 0,
          total: json['questions']?.length ?? 0,
        )).toList();
      } else {
        throw Exception('Failed to load results');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to load results');
      } else {
        throw Exception('Network error');
      }
    }
  }
}
