// test/presentation/home/home_page_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/home/home_page.dart';

void main() {
  testWidgets('HomePage renders correctly', (WidgetTester tester) async {
    // Build the HomePage widget inside a MaterialApp to provide context
    await tester.pumpWidget(
      const MaterialApp(
        home: HomePage(),
      ),
    );

    // Verify that HomePage contains a specific widget or text
    // Replace 'Welcome' with something that exists on your HomePage
    expect(find.text('Welcome'), findsOneWidget);

    // You can check for buttons, text fields, etc.
    expect(find.byType(ElevatedButton), findsWidgets);
  });

  // Add more widget tests as needed
}
