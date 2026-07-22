import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:frontend/application/previous_exam/previous_exam_notifier.dart';
import 'package:frontend/presentation/previous_exam/previous_exam_controller.dart';

// Mock classes
class MockPreviousExamController extends Mock implements PreviousExamController {}

void main() {
  late PreviousExamNotifier notifier;
  late MockPreviousExamController mockController;

  setUp(() {
    mockController = MockPreviousExamController();
    notifier = PreviousExamNotifier(controller: mockController);
    
    // Setup stubs for async methods
    when(() => mockController.viewExam(any())).thenAnswer((_) => Future<void>.value());
    when(() => mockController.continueExam(any())).thenAnswer((_) => Future<void>.value());
  });

  group('PreviousExamNotifier', () {
    test('should update firstQuizId when onFirstQuizIdChange is called', () {
      // Act
      notifier.onFirstQuizIdChange('test-id-1');
      
      // Assert
      expect(notifier.state.firstQuizId, equals('test-id-1'));
    });

    test('should update secondQuizId when onSecondQuizIdChange is called', () {
      // Act
      notifier.onSecondQuizIdChange('test-id-2');
      
      // Assert
      expect(notifier.state.secondQuizId, equals('test-id-2'));
    });

    test('should call viewExam when onViewClicked is called', () {
      // Arrange
      notifier.onFirstQuizIdChange('test-id-1');
      
      // Act
      notifier.onViewClicked();
      
      // Assert
      verify(() => mockController.viewExam('test-id-1')).called(1);
    });

    test('should call continueExam when onContinueClicked is called', () {
      // Arrange
      notifier.onSecondQuizIdChange('test-id-2');
      
      // Act
      notifier.onContinueClicked();
      
      // Assert
      verify(() => mockController.continueExam('test-id-2')).called(1);
    });
  });
}


