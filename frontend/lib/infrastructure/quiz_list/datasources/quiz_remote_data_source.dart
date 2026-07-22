import 'dart:async';
import 'package:dio/dio.dart'; // Assuming Dio is used for actual remote calls
import '../../../domain/quiz_list/entities/quiz.dart';

// Abstract class defining the contract for remote quiz operations
abstract class QuizRemoteDataSource {
  Future<List<Quiz>> fetchQuizzes();
  Future<void> removeQuiz(String id);
}

// Concrete implementation of the remote data source
class QuizRemoteDataSourceImpl implements QuizRemoteDataSource {
  // If you use Dio for actual API calls, inject it here
  final Dio? dio; // Made nullable for demonstration with dummy data

  QuizRemoteDataSourceImpl([this.dio]); // Constructor allows optional Dio injection

  @override
  Future<List<Quiz>> fetchQuizzes() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Dummy data, ideally this would be fetched from an API using 'dio'
    // For example: final response = await dio.get('/quizzes');
    // Then parse response.data into List<Quiz>
    return List.generate(
      7,
          (index) => Quiz(id: 'quiz_${index + 1}', title: 'Quiz ${index + 1}'),
    );
  }

  @override
  Future<void> removeQuiz(String id) async {
    // Simulate network delay for removal
    await Future.delayed(const Duration(milliseconds: 300));
    // Ideally, this would make an API call using 'dio' to delete the quiz
    // For example: await dio.delete('/quizzes/$id');
    // No return value needed as per Future<void>
  }
}
