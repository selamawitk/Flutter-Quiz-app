import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/presentation/result/result_page.dart';

void main() {
  testWidgets('ResultScreen shows score and total', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: ResultScreen(
          score: 7,
          total: 10,
          onDrawerItemClick: (_) {},
          onBackClick: () {},
          onNextClick: () {},
          currentPage: 'result',
        ),
      ),
    );

    expect(find.text('7 / 10'), findsOneWidget);
    expect(find.text('እርማት'), findsOneWidget);
  });

  testWidgets('Buttons work', (tester) async {
    bool nextClicked = false;
    bool backClicked = false;

    await tester.pumpWidget(
      MaterialApp(
        home: ResultScreen(
          score: 8,
          total: 10,
          onDrawerItemClick: (_) {},
          onBackClick: () => backClicked = true,
          onNextClick: () => nextClicked = true,
          currentPage: 'result',
        ),
      ),
    );

    await tester.tap(find.text('ጨርስ'));
    await tester.pump();
    expect(nextClicked, isTrue);
  });
}
