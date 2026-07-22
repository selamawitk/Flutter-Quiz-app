import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/reset_password/reset_password_widget.dart';

void main() {
  group('ResetPasswordWidgets Tests', () {
    group('PasswordInputField', () {
      testWidgets('should render password input field correctly', (WidgetTester tester) async {
        // arrange
        final controller = TextEditingController();

        // act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PasswordInputField(
                controller: controller,
                labelText: 'Password',
                hintText: 'Enter password',
              ),
            ),
          ),
        );

        // assert
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.text('Password'), findsOneWidget);
        expect(find.text('Enter password'), findsOneWidget);
      });

      testWidgets('should obscure text by default', (WidgetTester tester) async {
        // arrange
        final controller = TextEditingController();

        // act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PasswordInputField(
                controller: controller,
                labelText: 'Password',
              ),
            ),
          ),
        );

        // assert
        final textFieldFinder = find.descendant(
          of: find.byType(TextFormField),
          matching: find.byType(EditableText),
        );
        final editableText = tester.widget<EditableText>(textFieldFinder);
        expect(editableText.obscureText, true);
      });

      testWidgets('should toggle password visibility when eye icon is tapped', (WidgetTester tester) async {
        // arrange
        final controller = TextEditingController();

        // act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: PasswordInputField(
                controller: controller,
                labelText: 'Password',
              ),
            ),
          ),
        );

        // Initially obscured
        final textFieldFinder = find.descendant(
          of: find.byType(TextFormField),
          matching: find.byType(EditableText),
        );
        EditableText editableText = tester.widget<EditableText>(textFieldFinder);
        expect(editableText.obscureText, true);

        // Tap visibility toggle
        await tester.tap(find.byIcon(Icons.visibility));
        await tester.pump();

        // Should be visible now
        editableText = tester.widget<EditableText>(textFieldFinder);
        expect(editableText.obscureText, false);

        // Tap again to hide
        await tester.tap(find.byIcon(Icons.visibility_off));
        await tester.pump();

        // Should be obscured again
        editableText = tester.widget<EditableText>(textFieldFinder);
        expect(editableText.obscureText, true);
      });

      testWidgets('should call validator when provided', (WidgetTester tester) async {
        // arrange
        final controller = TextEditingController();
        bool validatorCalled = false;

        // act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Form(
                child: PasswordInputField(
                  controller: controller,
                  labelText: 'Password',
                  validator: (value) {
                    validatorCalled = true;
                    return value?.isEmpty == true ? 'Required' : null;
                  },
                ),
              ),
            ),
          ),
        );

        // Trigger validation
        await tester.enterText(find.byType(TextFormField), '');
        await tester.pump();

        // assert
        expect(validatorCalled, true);
        expect(find.text('Required'), findsOneWidget);
      });
    });

    group('ResetPasswordButton', () {
      testWidgets('should render button correctly', (WidgetTester tester) async {
        // arrange & act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ResetPasswordButton(
                onPressed: () {},
                isLoading: false,
              ),
            ),
          ),
        );

        // assert
        expect(find.byType(ElevatedButton), findsOneWidget);
        expect(find.text('Reset Password'), findsOneWidget);
      });

      testWidgets('should show loading indicator when loading', (WidgetTester tester) async {
        // arrange & act
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ResetPasswordButton(
                onPressed: () {},
                isLoading: true,
              ),
            ),
          ),
        );

        // assert
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.text('Reset Password'), findsNothing);
      });

      testWidgets('should call onPressed when tapped', (WidgetTester tester) async {
        // arrange
        bool buttonPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ResetPasswordButton(
                onPressed: () {
                  buttonPressed = true;
                },
                isLoading: false,
              ),
            ),
          ),
        );

        // act
        await tester.tap(find.byType(ElevatedButton));

        // assert
        expect(buttonPressed, true);
      });

      testWidgets('should be disabled when loading', (WidgetTester tester) async {
        // arrange
        bool buttonPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: ResetPasswordButton(
                onPressed: () {
                  buttonPressed = true;
                },
                isLoading: true,
              ),
            ),
          ),
        );

        // act
        await tester.tap(find.byType(ElevatedButton));

        // assert
        expect(buttonPressed, false);
      });
    });
  });
} 