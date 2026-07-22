import '../../../domain/quiz_list/entities/quiz.dart';

class QuizRemoteDataSource {
  Future<List<Quiz>> getQuizzes() async {
    // Dummy data (replace with real API later)
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Quiz(
        id: 'q1',
        title: 'Basic Quiz 1',
      ),
      Quiz(
        id: 'q2',
        title: 'Basic Quiz 2',
      ),
    ];
  }
}
