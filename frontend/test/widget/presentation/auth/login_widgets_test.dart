import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/auth/login_widgets.dart';

void main() {
  testWidgets('LoginInputField calls onChanged callback', (tester) async {
    String? changedValue;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: LoginInputField(
            icon: Icons.person,
            hintText: 'Username',
            onChanged: (value) => changedValue = value,
          ),
        ),
      ),
    );

    final input = find.byType(TextField);
    expect(input, findsOneWidget);

    await tester.enterText(input, 'hello');
    expect(changedValue, 'hello');
  });

  testWidgets('RoleRadio calls onChanged callback and displays text', (tester) async {
    String selectedValue = 'student';

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: RoleRadio(
            value: 'admin',
            groupValue: selectedValue,
            onChanged: (value) {
              selectedValue = value!;
            },
          ),
        ),
      ),
    );

    final radio = find.byType(Radio);
    expect(radio, findsOneWidget);
    expect(find.text('አስተማሪ'), findsOneWidget);

    await tester.tap(radio);
    await tester.pumpAndSettle();

    expect(selectedValue, 'admin');
  });
}
