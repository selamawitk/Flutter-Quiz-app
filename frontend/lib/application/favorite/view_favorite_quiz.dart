import '../../domain/favorite/favorite_quiz.dart';
import '../../domain/favorite/favorite_quiz_repository.dart';

class ViewFavoriteQuiz {
  final FavoriteQuizRepository repository;

  ViewFavoriteQuiz(this.repository);

  Future<void> call(FavoriteQuiz quiz) {
    return repository.viewQuiz(quiz);
  }
}
