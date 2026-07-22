import 'favorite_quiz.dart';
import '../../infrastructure/favorite/local_favorite_quiz_datasource.dart';

class GetFavoriteExam {
  final LocalFavoriteQuizDataSource repository;

  GetFavoriteExam(this.repository);

  Future<List<FavoriteQuiz>> call() async {
    // Since repository.getFavorites() is not async, we don't need to await it
    // but the method still returns a Future for consistency with other use cases
    return repository.getFavorites();
  }
}
