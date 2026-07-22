import '../entities/quiz.dart';

abstract class AddQuizRepository {
  Future<void> createQuiz(Quiz quiz);
}
