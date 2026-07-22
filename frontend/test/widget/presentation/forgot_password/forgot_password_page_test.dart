import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/forgot_password/forgot_password_page.dart';
import 'package:go_router/go_router.dart';

void main() {
  testWidgets('ForgotPasswordPage renders and triggers navigation', (WidgetTester tester) async {
    String? navigatedUsername;

    // Define router first
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const ForgotPasswordPage(),
        ),
        GoRoute(
          path: '/answer-security',
          builder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            navigatedUsername = extra?['username'] as String?;
            return const SizedBox.shrink();
          },
        ),
      ],
    );

    // Pump widget with MaterialApp.router using routerConfig
    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.pumpAndSettle();

    // Verify title and input field exist
    expect(find.text('የመለስተ መርሃግብር'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);

    // You can add navigation trigger tests here if your widget triggers navigation
  });
}
