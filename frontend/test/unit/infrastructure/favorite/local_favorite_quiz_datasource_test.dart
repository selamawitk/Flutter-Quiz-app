import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/favorite/favorite_quiz.dart';
import 'package:frontend/infrastructure/favorite/local_favorite_quiz_datasource.dart';

void main() {
  late LocalFavoriteQuizDataSource dataSource;

  setUp(() {
    dataSource = LocalFavoriteQuizDataSource();
  });

  test('saveFavorite adds quiz to storage', () {
    final quiz = FavoriteQuiz(id: '1', title: 'Math', description: 'Basic Algebra');
    dataSource.saveFavorite(quiz);

    expect(dataSource.getFavorites(), contains(quiz));
  });

  test('getFavorites returns all saved quizzes', () {
    final quiz1 = FavoriteQuiz(id: '1', title: 'Math', description: 'Algebra');
    final quiz2 = FavoriteQuiz(id: '2', title: 'Science', description: 'Biology');

    dataSource.saveFavorite(quiz1);
    dataSource.saveFavorite(quiz2);

    final allQuizzes = dataSource.getFavorites();
    expect(allQuizzes.length, 2);
    expect(allQuizzes, containsAll([quiz1, quiz2]));
  });

  test('getQuizById returns correct quiz', () {
    final quiz = FavoriteQuiz(id: '123', title: 'History', description: 'Ancient Egypt');
    dataSource.saveFavorite(quiz);

    final result = dataSource.getQuizById('123');
    expect(result?.id, '123');
    expect(result?.title, 'History');
  });

  test('getQuizById returns empty quiz if not found', () {
    final result = dataSource.getQuizById('not-found');
    expect(result?.id, '');
  });

  test('continueQuiz throws UnimplementedError', () {
    final quiz = FavoriteQuiz(id: '1', title: '', description: '');
    expect(() => dataSource.continueQuiz(quiz), throwsUnimplementedError);
  });

  test('viewQuiz throws UnimplementedError', () {
    final quiz = FavoriteQuiz(id: '1', title: '', description: '');
    expect(() => dataSource.viewQuiz(quiz), throwsUnimplementedError);
  });
}


