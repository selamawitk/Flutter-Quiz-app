import '../../domain/favorite/favorite_quiz.dart';
import '../../domain/favorite/favorite_quiz_repository.dart';
import 'local_favorite_quiz_datasource.dart';

class FavoriteQuizRepositoryImpl implements FavoriteQuizRepository {
  final LocalFavoriteQuizDataSource localDataSource;

  FavoriteQuizRepositoryImpl(this.localDataSource);

  @override
  Future<void> viewQuiz(FavoriteQuiz quiz) async {
    print('Viewing quiz: ${quiz.id}');
    // could use localDataSource.loadQuizData(quiz.id);
  }

  @override
  Future<void> continueQuiz(FavoriteQuiz quiz) async {
    print('Continuing quiz: ${quiz.id}');
    // could use localDataSource.resumeQuiz(quiz.id);
  }

}
