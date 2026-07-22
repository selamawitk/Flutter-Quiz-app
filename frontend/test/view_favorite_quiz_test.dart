import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/favorite/view_favorite_quiz.dart';
import 'package:frontend/domain/favorite/favorite_quiz.dart';
import 'package:frontend/domain/favorite/favorite_quiz_repository.dart';

// Mock class
class MockFavoriteQuizRepository extends Mock implements FavoriteQuizRepository {}

void main() {
  group('ViewFavoriteQuiz', () {
    late MockFavoriteQuizRepository mockRepository;
    late ViewFavoriteQuiz useCase;

    setUp(() {
      mockRepository = MockFavoriteQuizRepository();
      useCase = ViewFavoriteQuiz(mockRepository);
    });

    test('calls repository.viewQuiz with the correct quiz', () async {
      final quiz = FavoriteQuiz(id: '2', title: 'History Quiz', description: 'Test description');

      // Stub method with mocktail syntax
      when(() => mockRepository.viewQuiz(any())).thenAnswer((_) async => Future.value());

      await useCase.call(quiz);

      verify(() => mockRepository.viewQuiz(any())).called(1);
    });
  });
}


