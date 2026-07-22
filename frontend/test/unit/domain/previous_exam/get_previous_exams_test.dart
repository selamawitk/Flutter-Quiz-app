import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/previous_exam/get_previous_exams.dart';
import 'package:frontend/domain/previous_exam/previous_exam_repository.dart';

class MockPreviousExamRepository extends Mock implements PreviousExamRepository {}

void main() {
  late MockPreviousExamRepository mockRepository;
  late GetPreviousExam useCase;

  setUp(() {
    mockRepository = MockPreviousExamRepository();
    useCase = GetPreviousExam(mockRepository);
  });

  test('call() returns the repository instance', () {
    final result = useCase.call();
    expect(result, mockRepository);
  });
}
