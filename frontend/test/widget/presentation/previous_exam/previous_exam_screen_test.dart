import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/presentation/previous_exam/previous_exam_screen.dart';
import 'package:frontend/application/previous_exam/previous_exam_notifier.dart';

void main() {
  Widget createWidgetUnderTest() {
    return const ProviderScope(
      child: MaterialApp(
        home: PreviousExamPage(),
      ),
    );
  }

  testWidgets('renders previous exam screen without errors', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Just verify the screen renders without errors
    expect(find.byType(PreviousExamPage), findsOneWidget);
  });

  testWidgets('should contain text fields', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Just check that there are text input widgets
    expect(find.byType(TextField), findsWidgets);
  });
}