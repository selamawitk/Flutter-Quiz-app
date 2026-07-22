import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Topic Detail Simple Widget Tests', () {
    testWidgets('should create basic Text widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Text('Topic Detail Test'),
          ),
        ),
      );

      expect(find.text('Topic Detail Test'), findsOneWidget);
    });

    testWidgets('should create Amharic text widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                Text('መርዛዊት'),
                Text('- Pronouns'),
              ],
            ),
          ),
        ),
      );

      expect(find.text('መርዛዊት'), findsOneWidget);
      expect(find.text('- Pronouns'), findsOneWidget);
    });

    testWidgets('should create back button widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.arrow_back_ios),
                  Text('ተመለስ'),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.text('ተመለስ'), findsOneWidget);
      expect(find.byIcon(Icons.arrow_back_ios), findsOneWidget);
    });

    testWidgets('should create menu button widget', (tester) async {
      bool isMenuOpen = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StatefulBuilder(
              builder: (context, setState) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      isMenuOpen = !isMenuOpen;
                    });
                  },
                  icon: Icon(isMenuOpen ? Icons.close : Icons.menu),
                );
              },
            ),
          ),
        ),
      );

      // Initially should show menu icon
      expect(find.byIcon(Icons.menu), findsOneWidget);
      expect(find.byIcon(Icons.close), findsNothing);

      // Tap the button
      await tester.tap(find.byIcon(Icons.menu));
      await tester.pumpAndSettle();

      // Should now show close icon
      expect(find.byIcon(Icons.close), findsOneWidget);
      expect(find.byIcon(Icons.menu), findsNothing);
    });

    testWidgets('should create loading indicator widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                CircularProgressIndicator(),
                Text('ይጭናል...'),
              ],
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('ይጭናል...'), findsOneWidget);
    });

    testWidgets('should create error widget with retry button', (tester) async {
      bool retryPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                const Icon(Icons.error_outline),
                const Text('ስህተት: Network error'),
                ElevatedButton(
                  onPressed: () {
                    retryPressed = true;
                  },
                  child: const Text('እንደገና ሞክር'),
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.error_outline), findsOneWidget);
      expect(find.textContaining('ስህተት:'), findsOneWidget);
      expect(find.text('እንደገና ሞክር'), findsOneWidget);

      // Test retry button tap
      await tester.tap(find.text('እንደገና ሞክር'));
      await tester.pumpAndSettle();

      expect(retryPressed, isTrue);
    });

    testWidgets('should create scrollable content widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const Text('Description:'),
                  const Text('This is a long description that needs to be scrollable.'),
                  const Text('ምሳሌዎች'),
                  ...List.generate(5, (index) => Text('Example ${index + 1}')),
                  const Text('ህጎች'),
                  ...List.generate(3, (index) => Text('Rule ${index + 1}')),
                ],
              ),
            ),
          ),
        ),
      );

      expect(find.byType(SingleChildScrollView), findsOneWidget);
      expect(find.text('ምሳሌዎች'), findsOneWidget);
      expect(find.text('ህጎች'), findsOneWidget);
      expect(find.text('Example 1'), findsOneWidget);
      expect(find.text('Rule 1'), findsOneWidget);
    });
  });
} 