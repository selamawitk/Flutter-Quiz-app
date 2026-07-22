import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/quiz/quiz_page.dart';
import 'package:frontend/presentation/quiz/quiz_controller.dart';

void main() {
  testWidgets('QuizScreen displays question and options', (WidgetTester tester) async {
    final viewModel = QuizViewModel(
      questionText: 'What is 2 + 2?',
      options: ['3', '4', '5', '6'],
      correctAnswer: '4',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: QuizScreen(
          viewModel: viewModel,
          onNextClick: () {},
        ),
      ),
    );

    expect(find.text('What is 2 + 2?'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);
    expect(find.text('4'), findsOneWidget);
    expect(find.text('5'), findsOneWidget);
    expect(find.text('6'), findsOneWidget);
  });
}
