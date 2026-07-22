import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:frontend/domain/quiz_list/entities/quiz.dart';
import 'package:frontend/domain/quiz/repositories/quiz_repository.dart';
import 'package:frontend/application/quiz/usecases/fetch_quizzes.dart';

// Mock class using mocktail
class MockQuizRepository extends Mock implements QuizRepository {}

void main() {
  late FetchQuizzes usecase;
  late MockQuizRepository mockRepository;

  setUpAll(() {
    registerFallbackValue(Quiz(
      id: 'q1',
      title: 'Test Quiz',
    ));
  });

  setUp(() {
    mockRepository = MockQuizRepository();
    usecase = FetchQuizzes(mockRepository);
  });

  test('should fetch a list of quizzes from repository', () async {
    final quizzes = [
      Quiz(
        id: 'q1',
        title: 'Test Quiz 1',
      ),
    ];

    when(() => mockRepository.fetchQuizzes()).thenAnswer((_) async => quizzes);

    final result = await usecase.call();

    expect(result, quizzes);
    verify(() => mockRepository.fetchQuizzes()).called(1);
    verifyNoMoreInteractions(mockRepository);
  });
}
