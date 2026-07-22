import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/category/category_widgets.dart';

void main() {
  testWidgets('Back button renders and works', (WidgetTester tester) async {
    final navKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(MaterialApp(
      navigatorKey: navKey,
      home: Scaffold(body: buildBackButton(navKey.currentContext!)),
    ));

    expect(find.text('ተመለስ'), findsOneWidget);
  });
}
