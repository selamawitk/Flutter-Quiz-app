import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/add_resource/add_resource_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('AddResourcePage renders form fields and submit button', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: AddResourcePage()),
      ),
    );

    expect(find.text('Add New Resource'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2)); // title and URL
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Filling fields and tapping submit triggers action', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: AddResourcePage()),
      ),
    );

    await tester.enterText(find.byType(TextField).at(0), 'Intro to AI');
    await tester.enterText(find.byType(TextField).at(1), 'https://example.com');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); // trigger rebuild

    expect(find.text('Intro to AI'), findsOneWidget);
  });
}

