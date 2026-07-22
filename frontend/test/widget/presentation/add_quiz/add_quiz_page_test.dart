import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import your AddQuizPage and any necessary providers/models
import 'package:frontend/presentation/add_quiz/add_quiz_page.dart';

void main() {
  group('AddQuizPage Widget Tests', () {
    testWidgets('renders all input fields and submit button', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AddQuizPage(),
          ),
        ),
      );

      // Check presence of text fields for question and options
      expect(find.byKey(Key('questionTextField')), findsOneWidget);
      expect(find.byKey(Key('option1TextField')), findsOneWidget);
      expect(find.byKey(Key('option2TextField')), findsOneWidget);
      expect(find.byKey(Key('option3TextField')), findsOneWidget);
      expect(find.byKey(Key('option4TextField')), findsOneWidget);

      // Check presence of submit button
      expect(find.widgetWithText(ElevatedButton, 'Submit'), findsOneWidget);

      // Check presence of cancel button
      expect(find.widgetWithText(TextButton, 'Cancel'), findsOneWidget);
    });

    testWidgets('shows validation error if submit with empty fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AddQuizPage(),
          ),
        ),
      );

      // Tap submit without entering any text
      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
      await tester.pump();

      // Expect validation error text (example)
      expect(find.text('Please enter a question'), findsOneWidget);
      expect(find.text('Please enter all options'), findsWidgets);
    });

    testWidgets('accepts input and triggers submission', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AddQuizPage(),
          ),
        ),
      );

      // Enter sample text in all fields
      await tester.enterText(find.byKey(Key('questionTextField')), 'What is Flutter?');
      await tester.enterText(find.byKey(Key('option1TextField')), 'SDK');
      await tester.enterText(find.byKey(Key('option2TextField')), 'Library');
      await tester.enterText(find.byKey(Key('option3TextField')), 'Language');
      await tester.enterText(find.byKey(Key('option4TextField')), 'IDE');

      await tester.pump();

      // Tap submit button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit'));
      await tester.pump();

      // Here you would verify that submission logic was called, e.g. by mocking your use case/provider.
      // For now, you can check that no validation error is shown.
      expect(find.text('Please enter a question'), findsNothing);
    });

    testWidgets('cancel button clears all input fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            home: AddQuizPage(),
          ),
        ),
      );

      // Enter some text
      await tester.enterText(find.byKey(Key('questionTextField')), 'Sample Question');
      await tester.enterText(find.byKey(Key('option1TextField')), 'Option 1');
      await tester.pump();

      // Tap cancel button
      await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
      await tester.pump();

      // Verify all fields are cleared
      expect(find.text('Sample Question'), findsNothing);
      expect(find.text('Option 1'), findsNothing);
    });
  });
}

