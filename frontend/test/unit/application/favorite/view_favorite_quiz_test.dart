import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/favorite/view_favorite_quiz.dart';
import 'package:frontend/domain/favorite/favorite_quiz.dart';
import 'package:frontend/domain/favorite/favorite_quiz_repository.dart';

// Mock class using mocktail
class MockFavoriteQuizRepository extends Mock implements FavoriteQuizRepository {}

void main() {
  group('ViewFavoriteQuiz', () {
    late MockFavoriteQuizRepository mockRepository;
    late ViewFavoriteQuiz useCase;

    setUp(() {
      mockRepository = MockFavoriteQuizRepository();
      useCase = ViewFavoriteQuiz(mockRepository);

      // Register fallback value with all required fields
      registerFallbackValue(FavoriteQuiz(
        id: '0',
        title: 'Fallback Quiz',
        description: 'Fallback Description',
      ));
    });

    test('calls repository.viewQuiz with the correct quiz', () async {
      final quiz = FavoriteQuiz(
        id: '2',
        title: 'History Quiz',
        description: 'A quiz about history',
      );

      // Stub method
      when(() => mockRepository.viewQuiz(quiz)).thenAnswer((_) async {});

      await useCase.call(quiz);

      verify(() => mockRepository.viewQuiz(quiz)).called(1);
    });
  });
}



