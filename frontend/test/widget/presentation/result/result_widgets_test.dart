import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/result/result_page.dart';
import 'package:frontend/presentation/result/result_widgets.dart';  // <--- Add this import

void main() {
  testWidgets('Background image is displayed', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: Stack(
              children: [
                buildBackground(),
                const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );

    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('Result body shows score and buttons', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: buildResultBody(
                context,
                ResultScreen(
                  score: 5,
                  total: 10,
                  onDrawerItemClick: (_) {},
                  onBackClick: () {},
                  onNextClick: () {},
                  currentPage: 'result',
                ),
              ),
            );
          },
        ),
      ),
    );

    expect(find.text('5 / 10'), findsOneWidget);
    expect(find.text('ደግመህ ውሰድ'), findsOneWidget);
    expect(find.text('ጨርስ'), findsOneWidget);
  });
}
