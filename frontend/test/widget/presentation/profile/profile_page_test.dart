import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/profile/profile_page.dart';

void main() {
  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: ProfileScreen(
        currentPage: "መለያ",
        onDrawerItemClick: (_) {},
        onBackClick: () {},
      ),
    );
  }

  testWidgets('ProfileScreen displays menu icon', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    expect(find.byIcon(Icons.menu), findsOneWidget);
  });
}
