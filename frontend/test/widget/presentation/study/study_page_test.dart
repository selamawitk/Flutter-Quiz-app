import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/presentation/study/study_page.dart';

void main() {
  testWidgets('StudyPage renders without errors', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: StudyPage(),
        ),
      ),
    );

    // Verify the page renders
    expect(find.byType(StudyPage), findsOneWidget);
  });

  testWidgets('StudyPage shows loading indicator initially', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: StudyPage(),
        ),
      ),
    );

    // Should show loading initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('StudyPage shows back button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: StudyPage(),
        ),
      ),
    );

    // Wait for the page to load
    await tester.pump(const Duration(milliseconds: 600));

    // Should show back button
    expect(find.text('ተመለስ'), findsOneWidget);
  });
} 