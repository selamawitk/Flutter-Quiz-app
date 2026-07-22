import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/favorite/continue_favorite_quiz.dart';
import 'package:frontend/domain/favorite/favorite_quiz.dart';
import 'package:frontend/domain/favorite/favorite_quiz_repository.dart';

// Mock class using mocktail
class MockFavoriteQuizRepository extends Mock implements FavoriteQuizRepository {}

void main() {
  group('ContinueFavoriteQuiz', () {
    late MockFavoriteQuizRepository mockRepository;
    late ContinueFavoriteQuiz useCase;

    setUp(() {
      mockRepository = MockFavoriteQuizRepository();
      useCase = ContinueFavoriteQuiz(mockRepository);

      // Register fallback value for FavoriteQuiz with required description
      registerFallbackValue(FavoriteQuiz(
        id: '0',
        title: 'Fallback Quiz',
        description: 'Fallback description',
      ));
    });

    test('calls repository.continueQuiz with the correct quiz', () async {
      final quiz = FavoriteQuiz(
        id: '1',
        title: 'Math Quiz',
        description: 'Some description',
      );

      // Stub the method to return a future
      when(() => mockRepository.continueQuiz(quiz)).thenAnswer((_) async {});

      await useCase.call(quiz);

      // Verify the interaction
      verify(() => mockRepository.continueQuiz(quiz)).called(1);
    });
  });
}



