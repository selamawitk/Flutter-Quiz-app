import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/previous_exam/previous_exam_notifier.dart';
import 'package:frontend/presentation/previous_exam/previous_exam_controller.dart';

class MockPreviousExamController extends Mock implements PreviousExamController {}

void main() {
  late MockPreviousExamController mockController;

  setUp(() {
    mockController = MockPreviousExamController();
    when(() => mockController.viewExam(any())).thenAnswer((_) => Future<void>.value());
    when(() => mockController.continueExam(any())).thenAnswer((_) => Future<void>.value());
  });

  test('PreviousExamNotifier state copyWith works correctly', () {
    var state = PreviousExamState();
    expect(state.firstQuizId, '');

    state = state.copyWith(firstQuizId: 'id1');
    expect(state.firstQuizId, 'id1');

    state = state.copyWith(secondQuizId: 'id2');
    expect(state.secondQuizId, 'id2');
  });

  test('viewExam calls controller with correct quiz id', () async {
    await mockController.viewExam('quiz1');
    verify(() => mockController.viewExam('quiz1')).called(1);
  });

  test('continueExam calls controller with correct quiz id', () async {
    await mockController.continueExam('quiz2');
    verify(() => mockController.continueExam('quiz2')).called(1);
  });
}
