import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/previous_exam/view_previous_exam.dart';
import 'package:frontend/domain/previous_exam/previous_exam.dart';
import 'package:frontend/domain/previous_exam/previous_exam_repository.dart';

// Mock class using mocktail
class MockPreviousExamRepository extends Mock implements PreviousExamRepository {}

void main() {
  late MockPreviousExamRepository mockRepository;
  late ViewPreviousExam useCase;

  // Register fallback value for PreviousExam with only 'id' parameter
  setUpAll(() {
    registerFallbackValue(PreviousExam(id: ''));
  });

  setUp(() {
    mockRepository = MockPreviousExamRepository();
    useCase = ViewPreviousExam(mockRepository);
  });

  group('ViewPreviousExam', () {
    test('calls repository.viewExam with the correct exam', () async {
      final exam = PreviousExam(id: 'EX001');

      when(() => mockRepository.viewExam(exam))
          .thenAnswer((_) async => Future.value());

      await useCase.call(exam);

      verify(() => mockRepository.viewExam(exam)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}


