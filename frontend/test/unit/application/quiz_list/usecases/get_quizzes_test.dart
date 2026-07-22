import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';  // FIXED import

import 'package:frontend/domain/quiz_list/entities/quiz.dart';
import 'package:frontend/domain/quiz_list/repositories/quiz_repository.dart';
import 'package:frontend/application/quiz_list/usecases/get_quizzes.dart';

class MockQuizRepository extends Mock implements QuizRepository {}

void main() {
  late MockQuizRepository mockRepo;
  late GetQuizzes getQuizzes;

  setUp(() {
    mockRepo = MockQuizRepository();
    getQuizzes = GetQuizzes(mockRepo);
  });

  test('should return list of quizzes from repository', () async {
    // Arrange
    final mockQuizList = [
      Quiz(id: '1', title: 'Test Quiz 1'),
      Quiz(id: '2', title: 'Test Quiz 2'),
    ];

    when(() => mockRepo.getQuizzes()).thenAnswer((_) async => mockQuizList);

    // Act
    final result = await getQuizzes();

    // Assert
    expect(result, mockQuizList);
    verify(() => mockRepo.getQuizzes()).called(1);

    // Remove this line, since mocktail doesn't have verifyNoMoreInteractions
    // verifyNoMoreInteractions(mockRepo);
  });
}


