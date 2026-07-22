import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/favorite/favorite_quiz_notifier.dart';
import 'package:frontend/application/favorite/view_favorite_quiz.dart';
import 'package:frontend/application/favorite/continue_favorite_quiz.dart';
import 'package:frontend/domain/favorite/favorite_quiz.dart';

// Mock classes using mocktail
class MockViewFavoriteQuiz extends Mock implements ViewFavoriteQuiz {}
class MockContinueFavoriteQuiz extends Mock implements ContinueFavoriteQuiz {}

void main() {
  late MockViewFavoriteQuiz mockViewUseCase;
  late MockContinueFavoriteQuiz mockContinueUseCase;
  late FavoriteQuizNotifier notifier;

  setUp(() {
    mockViewUseCase = MockViewFavoriteQuiz();
    mockContinueUseCase = MockContinueFavoriteQuiz();
    notifier = FavoriteQuizNotifier(
      viewUseCase: mockViewUseCase,
      continueUseCase: mockContinueUseCase,
    );

    // Register fallback value for FavoriteQuiz
    registerFallbackValue(FavoriteQuiz(id: '', title: '', description: ''));
  });

  test('onViewClicked calls viewUseCase with correct quiz ID', () {
    const id = 'quiz123';
    notifier.updateFirstQuizId(id);

    final expectedQuiz = FavoriteQuiz(id: id, title: '', description: '');

    // Return a Future<void>, not null
    when(() => mockViewUseCase.call(expectedQuiz))
        .thenAnswer((_) async {});

    notifier.onViewClicked();

    verify(() => mockViewUseCase.call(expectedQuiz)).called(1);
  });

  test('onContinueClicked calls continueUseCase with correct quiz ID', () {
    const id = 'quiz456';
    notifier.updateSecondQuizId(id);

    final expectedQuiz = FavoriteQuiz(id: id, title: '', description: '');

    when(() => mockContinueUseCase.call(expectedQuiz))
        .thenAnswer((_) async {});

    notifier.onContinueClicked();

    verify(() => mockContinueUseCase.call(expectedQuiz)).called(1);
  });
}



