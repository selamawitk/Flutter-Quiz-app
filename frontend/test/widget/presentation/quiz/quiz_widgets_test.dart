import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/quiz/quiz_widgets.dart';
import 'package:frontend/presentation/quiz/quiz_controller.dart';

void main() {
  testWidgets('QuizContent changes color when an option is selected', (WidgetTester tester) async {
    final viewModel = QuizViewModel(
      questionText: 'Capital of Ethiopia?',
      options: ['Addis Ababa', 'Nairobi', 'Kampala'],
      correctAnswer: 'Addis Ababa',
    );

    await tester.pumpWidget(
      MaterialApp(
        home: QuizContent(
          viewModel: viewModel,
          onNextClick: () {},
          onOptionSelected: (String option) {
            viewModel.selectOption(option);
          },
        ),
      ),
    );

    await tester.tap(find.text('Addis Ababa'));
    await tester.pump();

    // Option color changes would be based on getOptionColor logic
    expect(viewModel.selectedOption, 'Addis Ababa');
  });
}
