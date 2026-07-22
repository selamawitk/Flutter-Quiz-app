import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/previous_exam/continue_previous_exam.dart';
import 'package:frontend/domain/previous_exam/previous_exam.dart';
import 'package:frontend/domain/previous_exam/previous_exam_repository.dart';

// Mock class
class MockPreviousExamRepository extends Mock implements PreviousExamRepository {}

void main() {
  group('ContinuePreviousExam', () {
    late MockPreviousExamRepository mockRepository;
    late ContinuePreviousExam useCase;

    setUp(() {
      mockRepository = MockPreviousExamRepository();
      useCase = ContinuePreviousExam(mockRepository);
    });

    test('calls repository.continueExam with the correct exam', () async {
      final exam = PreviousExam(id: '10');

      when(() => mockRepository.continueExam(exam)).thenAnswer((_) async => Future.value());

      await useCase.call(exam);

      verify(() => mockRepository.continueExam(exam)).called(1);
    });
  });
}
