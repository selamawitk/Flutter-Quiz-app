import 'package:dio/dio.dart';
import '../../../domain/answer_security/entities/answer_security.dart';
import '../../core/network/http_client.dart';

abstract class AnswerSecurityRemoteDataSource {
  Future<AnswerSecurity> verifySecurityAnswer(String username, String answer);
  Future<String> getSecurityQuestion(String username);
  Future<bool> updateSecurityQuestion(String username, String question, String answer);
}

class AnswerSecurityRemoteDataSourceImpl implements AnswerSecurityRemoteDataSource {
  final HttpClient _httpClient = HttpClient();

  @override
  Future<AnswerSecurity> verifySecurityAnswer(String username, String answer) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/verify-security-answers',
        data: {
          'username': username,
          'providedAnswers': {'answer': answer},
        },
      );

      if (response.statusCode == 200) {
        return AnswerSecurity(
          username: username,
          securityQuestion: '',
          securityAnswer: answer,
          isVerified: response.data['resetToken'] != null,
          verificationToken: response.data['resetToken'],
        );
      } else {
        throw Exception('Failed to verify security answer');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(e.response?.data['message'] ?? 'Failed to verify security answer');
      } else {
        throw Exception('Network error');
      }
    }
  }

  @override
  Future<String> getSecurityQuestion(String username) async {
    try {
      final response = await _httpClient.dio.get(
        '/auth/security-questions/$username',
      );

      if (response.statusCode == 200) {
        final questions = response.data['questions'];
        if (questions is Map) {
          return questions.values.first.toString();
        }
        return questions.toString();
      } else {
        throw Exception('Security question not found');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw Exception('User not found');
      }
      throw Exception('Failed to get security question: ${e.message}');
    }
  }

  @override
  Future<bool> updateSecurityQuestion(String username, String question, String answer) async {
    try {
      final response = await _httpClient.dio.post(
        '/auth/security-questions',
        data: {
          'username': username,
          'securityQuestions': {
            'question1': {'question': question, 'answer': answer},
          },
        },
      );

      return response.statusCode == 200;
    } on DioException catch (e) {
      throw Exception('Failed to update security question: ${e.message}');
    }
  }
}
