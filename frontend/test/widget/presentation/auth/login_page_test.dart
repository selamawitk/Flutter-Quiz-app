import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/auth/login_controller.dart';
import 'package:frontend/presentation/auth/login_page.dart';
import 'package:mocktail/mocktail.dart';

// Mock for LoginController
class MockLoginController extends Mock implements LoginController {}

void main() {
  late LoginController mockController;

  setUp(() {
    mockController = MockLoginController();

    // Provide fallback values if needed for state
    when(() => mockController.state).thenReturn(LoginState.initial());
  });

  Widget createWidgetUnderTest() {
    return ProviderScope(
      overrides: [
        loginControllerProvider.overrideWith((ref) => mockController),
      ],
      child: const MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  testWidgets('renders login screen elements', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text('ለመግባት'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('ተማሪ'), findsOneWidget);
    expect(find.text('አስተማሪ'), findsOneWidget);
    expect(find.text('ግባ'), findsOneWidget);
    expect(find.text('የሚስጥር ቁጥር ከረሱ'), findsOneWidget);
    expect(find.text('ይመዝገቡ'), findsOneWidget);
  });

  testWidgets('calls setUsername when username typed', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    final usernameField = find.byType(TextField).at(0);
    await tester.enterText(usernameField, 'testuser');

    // Since setUsername is a method on the controller, verify it was called
    verify(() => mockController.setUsername('testuser')).called(1);
  });

  testWidgets('shows CircularProgressIndicator when loading', (tester) async {
    when(() => mockController.state).thenReturn(LoginState.initial().copyWith(isLoading: true));
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
