import '../../domain/favorite/favorite_quiz.dart';
import '../../domain/favorite/favorite_quiz_repository.dart';

class LocalFavoriteQuizDataSource implements FavoriteQuizRepository {
  final List<FavoriteQuiz> _storage = [];

  void saveFavorite(FavoriteQuiz quiz) {
    _storage.add(quiz);
  }

  List<FavoriteQuiz> getFavorites() {
    return _storage;
  }

  FavoriteQuiz? getQuizById(String id) {
    if (id.isEmpty) return null;
    return _storage.firstWhere(
      (quiz) => quiz.id == id,
      orElse: () => FavoriteQuiz(id: '', title: '', description: ''),
    );
  }

  @override
  Future<void> continueQuiz(FavoriteQuiz quiz) async {
    // In-memory: quiz is already stored, nothing to do
  }

  @override
  Future<void> viewQuiz(FavoriteQuiz quiz) async {
    // In-memory: quiz is already stored, nothing to do
  }
}
