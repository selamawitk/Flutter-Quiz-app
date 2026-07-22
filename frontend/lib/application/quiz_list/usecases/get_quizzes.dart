import '../../../domain/quiz_list/entities/quiz.dart';
import '../../../domain/quiz_list/repositories/quiz_repository.dart';

class GetQuizzes {
  final QuizRepository repository;

  GetQuizzes(this.repository);

  Future<List<Quiz>> call() async {
    return await repository.getQuizzes();
  }
}
