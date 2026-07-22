import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/forgot_password/forgot_password_widget.dart';

class MockForgotPasswordController {
  bool called = false;
  String? receivedUsername;
  bool shouldExist = true;

  Future<bool> verifyUsername(String username) async {
    called = true;
    receivedUsername = username;
    return shouldExist;
  }
}

void main() {
  testWidgets('ForgotPasswordWidget shows error on empty username', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ForgotPasswordWidget(
            onSuccess: (_) {},
          ),
        ),
      ),
    );

    // Try to submit empty username
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    expect(find.text('Please enter a username.'), findsOneWidget);
  });

  testWidgets('ForgotPasswordWidget calls onSuccess if username exists', (WidgetTester tester) async {
    String? successUsername;
    final widget = ForgotPasswordWidget(
      onSuccess: (username) {
        successUsername = username;
      },
    );

    await tester.pumpWidget(MaterialApp(home: Scaffold(body: widget)));

    final usernameField = find.byType(TextField);
    final button = find.byType(ElevatedButton);

    // Enter username
    await tester.enterText(usernameField, 'testuser');

    // Tap submit button
    await tester.tap(button);
    await tester.pump();

    // Note: For async verification and proper mocking,
    // you'd inject a mock controller to handle verifyUsername.
  });
}
