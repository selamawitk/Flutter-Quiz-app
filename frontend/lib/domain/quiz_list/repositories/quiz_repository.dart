import '../entities/quiz.dart';

abstract class QuizRepository {
  Future<List<Quiz>> getQuizzes();
  Future<void> removeQuiz(String id);
}
