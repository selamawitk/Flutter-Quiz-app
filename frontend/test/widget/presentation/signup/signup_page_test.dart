import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:frontend/presentation/signup/signup_page.dart';
import 'package:frontend/presentation/signup/signup_controller.dart';

void main() {
  testWidgets('SignupScreen UI and navigation test', (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SignupScreen(),
        ),
        GoRoute(
          path: '/security-question',
          builder: (context, state) => const Scaffold(body: Text('Security Question Screen')),
        ),
        GoRoute(
          path: '/signin',
          builder: (context, state) => const Scaffold(body: Text('Sign In Screen')),
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp.router(
          routerConfig: router,
        ),
      ),
    );

    // Verify UI elements
    expect(find.text('ለመመዝገብ'), findsOneWidget);
    expect(find.byIcon(Icons.person), findsOneWidget);
    expect(find.byIcon(Icons.vpn_key), findsOneWidget);
    expect(find.text('ቀጥል'), findsOneWidget);
    expect(find.text('ከዚህ በፊት ተመዝግበዋል?'), findsOneWidget);
    expect(find.text('ይግቡ'), findsOneWidget);

    // Enter username and password
    await tester.enterText(find.byIcon(Icons.person), 'testuser');
    await tester.enterText(find.byIcon(Icons.vpn_key), 'password123');

    // Tap 'ቀጥል' button and verify navigation
    await tester.tap(find.text('ቀጥል'));
    await tester.pumpAndSettle();

    expect(find.text('Security Question Screen'), findsOneWidget);

    // Navigate back to signup for next test
    router.go('/');

    await tester.pumpAndSettle();

    // Tap 'ይግቡ' button and verify navigation
    await tester.tap(find.text('ይግቡ'));
    await tester.pumpAndSettle();

    expect(find.text('Sign In Screen'), findsOneWidget);
  });
}
