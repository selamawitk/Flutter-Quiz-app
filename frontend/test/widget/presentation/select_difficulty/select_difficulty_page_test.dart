import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/presentation/select_difficulty/select_difficulty_page.dart';

void main() {
  testWidgets('SelectDifficultyPage UI renders correctly and handles button taps', (WidgetTester tester) async {
    // A variable to capture the selected difficulty
    String? selectedDifficulty;

    // Build the widget inside a ProviderScope
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: SelectDifficultyPage(
            onDifficultySelected: (difficulty) {
              selectedDifficulty = difficulty;
            },
          ),
        ),
      ),
    );

    // Check that the logo is present
    expect(find.byType(Image), findsOneWidget);

    // Check that all three difficulty buttons exist
    expect(find.text('Easy'), findsOneWidget);
    expect(find.text('Medium'), findsOneWidget);
    expect(find.text('Hard'), findsOneWidget);

    // Check that tapping "Medium" triggers the callback
    await tester.tap(find.text('Medium'));
    await tester.pumpAndSettle();

    expect(selectedDifficulty, 'Medium');

    // Check the "Cancel" button
    expect(find.text('Cancel'), findsOneWidget);

    // Tap "Cancel" and ensure selectedDifficulty is still 'Medium' (no effect)
    await tester.tap(find.text('Cancel'));
    await tester.pumpAndSettle();

    expect(selectedDifficulty, 'Medium'); // Remains unchanged
  });
}

