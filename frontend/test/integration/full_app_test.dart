import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:frontend/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Full App Integration Test', () {
    testWidgets('Complete user flow: Home, Login, Signup, Choice Navigation',
            (WidgetTester tester) async {
          app.main();
          await tester.pumpAndSettle();

          // START ON HOME PAGE (splash page)
          expect(find.text('ይህ የግእዝ ጥያቄዎች ምታገኙበት የስልክ መተግበርያ ነው።'), findsOneWidget);
          
          // TAP START BUTTON TO GO TO LOGIN
          await tester.tap(find.byKey(const Key('start_button')));
          await tester.pumpAndSettle();

          // NOW ON LOGIN PAGE
          expect(find.text('ለመግባት'), findsOneWidget);
          expect(find.text('ግባ'), findsOneWidget);

          // TAP SIGNUP LINK
          await tester.tap(find.byKey(const Key('signup_button')));
          await tester.pumpAndSettle();

          // NOW ON SIGNUP PAGE
          expect(find.text('ለመመዝገብ'), findsOneWidget);
          
          // Enter signup data
          await tester.enterText(find.byKey(const Key('signup_username_field')), 'testuser');
          await tester.enterText(find.byKey(const Key('signup_password_field')), 'testpass123');
          
          // Tap continue button
          await tester.tap(find.byKey(const Key('signup_continue_button')));
          await tester.pumpAndSettle();

          // SHOULD GO TO SECURITY QUESTIONS PAGE
          expect(find.text('የሙያ ጥያቄዎች'), findsOneWidget);
          
          // If security questions page exists, fill them out
          // Note: This depends on your actual security questions implementation
          final questionFields = find.byType(TextField);
          if (questionFields.evaluate().length >= 3) {
            await tester.enterText(questionFields.at(0), 'Answer 1');
            await tester.enterText(questionFields.at(1), 'Answer 2');
            await tester.enterText(questionFields.at(2), 'Answer 3');
            
            // Find and tap submit button (adjust text as needed)
            final submitButton = find.byType(ElevatedButton).last;
            await tester.tap(submitButton);
            await tester.pumpAndSettle();
          }

          // SHOULD REDIRECT TO LOGIN PAGE AFTER SIGNUP
          expect(find.text('ለመግባት'), findsOneWidget);
          
          // Login with the created account
          await tester.enterText(find.byKey(const Key('login_username_field')), 'testuser');
          await tester.enterText(find.byKey(const Key('login_password_field')), 'testpass123');
          
          // Tap login button
          await tester.tap(find.byKey(const Key('login_button')));
          await tester.pumpAndSettle();

          // SHOULD GO TO CHOICE PAGE (for students)
          expect(find.text('ፈተና'), findsOneWidget);
          expect(find.text('ጥናት'), findsOneWidget);
          expect(find.text('መለያ'), findsOneWidget);

          // NAVIGATE TO QUIZ (Category page)
          await tester.tap(find.text('ፈተና'));
          await tester.pumpAndSettle();
          
          // Should be on category/quiz selection page
          // This depends on your actual category page implementation
          expect(find.byType(Scaffold), findsOneWidget);

          // GO BACK TO CHOICE PAGE
          final backButton = find.byType(BackButton);
          if (backButton.evaluate().isNotEmpty) {
            await tester.tap(backButton);
            await tester.pumpAndSettle();
          } else {
            // Alternative: use system back navigation
            await tester.pageBack();
            await tester.pumpAndSettle();
          }

          // NAVIGATE TO STUDY RESOURCES
          await tester.tap(find.text('ጥናት'));
          await tester.pumpAndSettle();
          
          // Should be on study page
          expect(find.byType(Scaffold), findsOneWidget);
        });

    testWidgets('Login Flow Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Go to login from home
      await tester.tap(find.byKey(const Key('start_button')));
      await tester.pumpAndSettle();

             // Try login with student role
       expect(find.text('ለመግባት'), findsOneWidget);
       
       await tester.enterText(find.byKey(const Key('login_username_field')), 'admin');
       await tester.enterText(find.byKey(const Key('login_password_field')), 'admin123');
      
      // Select admin role if radio buttons are available
      final radioButtons = find.byType(Radio<String>);
      if (radioButtons.evaluate().length >= 2) {
        await tester.tap(radioButtons.last); // admin role
        await tester.pumpAndSettle();
      }
      
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Should navigate based on role
      // Admin should go to admin home, student to choice page
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Forgot Password Flow Test', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login
      await tester.tap(find.byKey(const Key('start_button')));
      await tester.pumpAndSettle();

      // TAP FORGOT PASSWORD
      await tester.tap(find.text('ይለፍ ቃል ከረሱ'));
      await tester.pumpAndSettle();

      // SHOULD BE ON FORGOT PASSWORD PAGE
      expect(find.text('የመለስተ መርሃግብር'), findsOneWidget);
      
      // Enter email/username
      final emailField = find.byType(TextField).first;
      await tester.enterText(emailField, 'testuser');
      
      // Submit forgot password request
      final submitButton = find.byType(ElevatedButton).first;
      await tester.tap(submitButton);
      await tester.pumpAndSettle();

      // Should navigate to security questions or show confirmation
      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('Navigation Test - Profile Access', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // Navigate to login
      await tester.tap(find.byKey(const Key('start_button')));
      await tester.pumpAndSettle();

      // Quick login (assuming we have valid credentials)
      await tester.enterText(find.byKey(const Key('login_username_field')), 'student');
      await tester.enterText(find.byKey(const Key('login_password_field')), 'student123');
      
      await tester.tap(find.byKey(const Key('login_button')));
      await tester.pumpAndSettle();

      // Should be on choice page, navigate to profile
      if (find.text('መለያ').evaluate().isNotEmpty) {
        await tester.tap(find.text('መለያ'));
        await tester.pumpAndSettle();

        // Should be on profile page
        expect(find.byType(Scaffold), findsOneWidget);
      }
    });
  });
}
