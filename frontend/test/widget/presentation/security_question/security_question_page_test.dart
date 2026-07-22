import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

import 'package:frontend/presentation/security_question/security_question_page.dart';
import 'package:frontend/presentation/security_question/security_question_controller.dart';

void main() {
  testWidgets('SecurityQuestionPage UI and submit button navigates', (WidgetTester tester) async {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SecurityQuestionPage(),
        ),
        GoRoute(
          path: '/choice',
          builder: (context, state) => const Scaffold(body: Text('Choice Page')),
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

    // Verify widgets are shown
    expect(find.text('ጥያቄ 1'), findsOneWidget);
    expect(find.text('መልስ 1'), findsOneWidget);
    expect(find.text('ጥያቄ 2'), findsOneWidget);
    expect(find.text('መልስ 2'), findsOneWidget);
    expect(find.text('ተመዝገብ'), findsOneWidget);

    // Enter some text in the inputs
    await tester.enterText(find.widgetWithText(TextField, 'ጥያቄ 1'), 'Question One');
    await tester.enterText(find.widgetWithText(TextField, 'መልስ 1'), 'Answer One');
    await tester.enterText(find.widgetWithText(TextField, 'ጥያቄ 2'), 'Question Two');
    await tester.enterText(find.widgetWithText(TextField, 'መልስ 2'), 'Answer Two');

    // Tap the submit button
    await tester.tap(find.text('ተመዝገብ'));
    await tester.pumpAndSettle();

    // Should navigate to /choice route
    expect(find.text('Choice Page'), findsOneWidget);
  });
}
