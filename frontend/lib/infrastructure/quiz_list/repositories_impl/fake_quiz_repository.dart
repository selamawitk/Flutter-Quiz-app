import 'package:frontend/domain/quiz_list/entities/quiz.dart';
import 'package:frontend/domain/quiz_list/repositories/quiz_repository.dart';
class FakeQuizRepository implements QuizRepository {
  @override
  Future<List<Quiz>> getQuizzes() async => [];

  @override
  Future<void> removeQuiz(String id) async {}
}
