import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/favorite/favorite_quiz.dart';
import 'package:frontend/infrastructure/favorite/favorite_quiz_repository_impl.dart';
import 'package:frontend/infrastructure/favorite/local_favorite_quiz_datasource.dart';

// Mock class using mocktail
class MockLocalFavoriteQuizDataSource extends Mock implements LocalFavoriteQuizDataSource {}

void main() {
  late MockLocalFavoriteQuizDataSource mockDataSource;
  late FavoriteQuizRepositoryImpl repository;

  setUp(() {
    mockDataSource = MockLocalFavoriteQuizDataSource();
    repository = FavoriteQuizRepositoryImpl(mockDataSource);
  });

  test('viewQuiz completes without error', () async {
    final quiz = FavoriteQuiz(id: 'abc', title: 'Sample', description: 'Test');

    // If viewQuiz calls some method on datasource, stub it (optional if no calls)
    when(() => mockDataSource.viewQuiz(quiz)).thenAnswer((_) async {});

    await repository.viewQuiz(quiz);
    // No assert, just ensuring no exceptions
  });

  test('continueQuiz completes without error', () async {
    final quiz = FavoriteQuiz(id: 'xyz', title: 'Sample', description: 'Test');

    when(() => mockDataSource.continueQuiz(quiz)).thenAnswer((_) async {});

    await repository.continueQuiz(quiz);
  });
}



