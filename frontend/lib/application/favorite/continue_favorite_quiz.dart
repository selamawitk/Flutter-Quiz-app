import '../../domain/favorite/favorite_quiz.dart';
import '../../domain/favorite/favorite_quiz_repository.dart';

class ContinueFavoriteQuiz {
  final FavoriteQuizRepository repository;

  ContinueFavoriteQuiz(this.repository);

  Future<void> call(FavoriteQuiz quiz) {
    return repository.continueQuiz(quiz);
  }
}
