import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/presentation/security_question/question_input.dart';

void main() {
  testWidgets('QuestionInput shows hint and calls onChanged', (WidgetTester tester) async {
    String text = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QuestionInput(
            hint: 'Test Hint',
            onChanged: (value) {
              text = value;
            },
          ),
        ),
      ),
    );

    // Verify hint text exists
    expect(find.text('Test Hint'), findsOneWidget);

    // Enter text and check onChanged is triggered
    await tester.enterText(find.byType(TextField), 'Hello');
    expect(text, 'Hello');
  });
}
