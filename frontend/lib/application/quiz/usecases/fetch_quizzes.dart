import '../../../domain/quiz_list/entities/quiz.dart';
import '../../../domain/quiz/repositories/quiz_repository.dart';

class FetchQuizzes {
  final QuizRepository repository;

  FetchQuizzes(this.repository);

  Future<List<Quiz>> call() {
    return repository.fetchQuizzes();
  }
}
