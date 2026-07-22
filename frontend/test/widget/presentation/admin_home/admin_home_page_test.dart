import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/presentation/admin_home/admin_home_page.dart';

void main() {
  testWidgets('AdminHomePage renders logo and menu buttons', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: AdminHomePage(),
        ),
      ),
    );

    expect(find.text('User List'), findsOneWidget);
    expect(find.text('Quizz List'), findsOneWidget);
    expect(find.text('Resource List'), findsOneWidget);
  });
}

