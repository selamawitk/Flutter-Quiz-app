// test/choice/choice_widgets_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:frontend/widgets/custom_button.dart';

void main() {
  testWidgets('CustomButton displays text and triggers onPressed', (WidgetTester tester) async {
    bool pressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: 'Test Button',
            onPressed: () {
              pressed = true;
            },
          ),
        ),
      ),
    );

    // Verify button text
    expect(find.text('Test Button'), findsOneWidget);

    // Tap button and verify callback
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();
    expect(pressed, true);
  });
}
