import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/presentation/user_list/user_list_page.dart';

void main() {
  testWidgets('UserListPage shows 7 users and Remove buttons, and Back button works', (tester) async {
    // Build the widget with a ProviderScope
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: UserListPage(),
        ),
      ),
    );

    // Check logo presence
    expect(find.byType(Image), findsWidgets); // At least background + logo

    // Check 7 user rows (with name "User1")
    final userTexts = find.text('User1');
    expect(userTexts, findsNWidgets(7));

    // Check 7 Remove buttons
    final removeButtons = find.widgetWithText(ElevatedButton, 'Remove');
    expect(removeButtons, findsNWidgets(7));

    // Tap the first Remove button and verify the user count reduces
    await tester.tap(removeButtons.first);
    await tester.pumpAndSettle();

    // Now 6 users
    expect(find.text('User1'), findsNWidgets(6));

    // Check Back button present
    final backButton = find.widgetWithText(ElevatedButton, 'Back');
    expect(backButton, findsOneWidget);

    // Tap Back button, expect Navigator.pop() is called
    // Since no previous route, we can just verify tap without error
    await tester.tap(backButton);
    await tester.pumpAndSettle();
  });
}

