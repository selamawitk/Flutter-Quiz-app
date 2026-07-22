// test/widget/presentation/profile/profile_widgets_test.dart

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/profile/profile_page.dart';

void main() {
  testWidgets('EditProfileButton renders and can be tapped', (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: EditProfileButton(
          key: const Key('editProfile'),
        ),
      ),
    ));

    expect(find.byKey(const Key('editProfile')), findsOneWidget);
  });

  testWidgets('ArchiveButton renders and can be tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: ArchiveButton())));
    expect(find.text("የፈተና ማህደር"), findsOneWidget);
  });

  testWidgets('FavoriteButton renders and can be tapped', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: Scaffold(body: FavoriteButton())));
    expect(find.text("🖤 የተመረጡ ፈተናዎች"), findsOneWidget);
  });

  testWidgets('LogoutButton calls onPressed when tapped', (WidgetTester tester) async {
    bool pressed = false;
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: LogoutButton(
          onPressed: () => pressed = true,
        ),
      ),
    ));

    await tester.tap(find.byType(LogoutButton));
    expect(pressed, true);
  });
}
