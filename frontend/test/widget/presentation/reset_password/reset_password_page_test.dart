import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/reset_password/reset_password_page.dart';

void main() {
  group('ResetPasswordPage Widget Tests', () {
    testWidgets('should render reset password page correctly', (WidgetTester tester) async {
      // arrange & act
      await tester.pumpWidget(
        MaterialApp(
          home: ResetPasswordPage(username: 'testuser', resetToken: 'test-token'),
        ),
      );

      // assert
      expect(find.byType(ResetPasswordPage), findsOneWidget);
      expect(find.text('Reset Password'), findsOneWidget);
      expect(find.text('testuser'), findsOneWidget);
    });

    testWidgets('should have password input fields', (WidgetTester tester) async {
      // arrange & act
      await tester.pumpWidget(
        MaterialApp(
          home: ResetPasswordPage(username: 'testuser', resetToken: 'test-token'),
        ),
      );

      // assert
      expect(find.byType(TextField), findsAtLeastNWidgets(2));
      expect(find.text('New Password'), findsOneWidget);
      expect(find.text('Confirm Password'), findsOneWidget);
    });

    testWidgets('should have submit button', (WidgetTester tester) async {
      // arrange & act
      await tester.pumpWidget(
        MaterialApp(
          home: ResetPasswordPage(username: 'testuser', resetToken: 'test-token'),
        ),
      );

      // assert
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.text('Reset Password'), findsAtLeastNWidgets(1));
    });

    testWidgets('should show validation errors for empty fields', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(
        MaterialApp(
          home: ResetPasswordPage(username: 'testuser', resetToken: 'test-token'),
        ),
      );

      // act
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // assert
      expect(find.text('Please enter new password'), findsOneWidget);
      expect(find.text('Please confirm password'), findsOneWidget);
    });

    testWidgets('should show error when passwords do not match', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(
        MaterialApp(
          home: ResetPasswordPage(username: 'testuser', resetToken: 'test-token'),
        ),
      );

      // act
      await tester.enterText(find.byKey(const Key('newPassword')), 'password1');
      await tester.enterText(find.byKey(const Key('confirmPassword')), 'password2');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      // assert
      expect(find.text('Passwords do not match'), findsOneWidget);
    });

    testWidgets('should enable submit button when form is valid', (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(
        MaterialApp(
          home: ResetPasswordPage(username: 'testuser', resetToken: 'test-token'),
        ),
      );

      // act
      await tester.enterText(find.byKey(const Key('newPassword')), 'password123');
      await tester.enterText(find.byKey(const Key('confirmPassword')), 'password123');
      await tester.pump();

      // assert
      final submitButton = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(submitButton.onPressed, isNotNull);
    });
  });
} 