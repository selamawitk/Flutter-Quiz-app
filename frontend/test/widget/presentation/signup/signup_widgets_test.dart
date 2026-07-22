import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/presentation/signup/signup_widgets.dart';

void main() {
  testWidgets('CustomInputField shows hint, icon and calls onChanged', (WidgetTester tester) async {
    String inputValue = '';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomInputField(
            hint: 'Test Hint',
            icon: Icons.person,
            obscureText: false,
            onChanged: (value) {
              inputValue = value;
            },
          ),
        ),
      ),
    );

    // Verify hint text and icon present
    expect(find.text('Test Hint'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);

    // Enter text and verify onChanged callback is called
    await tester.enterText(find.byType(TextField), 'Hello Flutter');
    expect(inputValue, 'Hello Flutter');
  });

  testWidgets('CustomInputField obscureText hides input', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomInputField(
            hint: 'Password',
            icon: Icons.vpn_key,
            obscureText: true,
            onChanged: (_) {},
          ),
        ),
      ),
    );

    final textField = tester.widget<TextField>(find.byType(TextField));
    expect(textField.obscureText, true);
  });
}
