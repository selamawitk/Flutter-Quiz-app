import 'package:dio/dio.dart';
import '../../../domain/add_quiz/entities/quiz.dart';
import '../../core/network/http_client.dart';

abstract class AddQuizRemoteDataSource {
  Future<void> createQuiz(Quiz quiz);
}

class AddQuizRemoteDataSourceImpl implements AddQuizRemoteDataSource {
  final HttpClient _httpClient = HttpClient();

  @override
  Future<void> createQuiz(Quiz quiz) async {
    try {
      final response = await _httpClient.dio.post(
        '/quiz',
        data: {
          'title': quiz.question,
          'description': '',
          'difficulty': 'easy',
          'questions': [
            {
              'questionText': quiz.question,
              'options': quiz.options,
              'correctAnswer': quiz.options.isNotEmpty ? quiz.options.first : '',
            }
          ],
        },
      );

      if (response.statusCode != 201) {
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
}
