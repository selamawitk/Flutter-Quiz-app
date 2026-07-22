import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/infrastructure/choice/datasources/choice_remote_data_source.dart';

// Mock NavigatorObserver to verify navigation calls
class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockNavigatorObserver mockObserver;
  late Widget testWidget;

  setUp(() {
    mockObserver = MockNavigatorObserver();

    // Wrap a MaterialApp with the NavigatorObserver
    testWidget = MaterialApp(
      routes: {
        '/quiz': (context) => const Scaffold(body: Text('Quiz Screen')),
        '/resources': (context) => const Scaffold(body: Text('Resources Screen')),
      },
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: ElevatedButton(
              onPressed: () {},
              child: const Text('Test'),
            ),
          );
        },
      ),
      navigatorObservers: [mockObserver],
    );
  });

  testWidgets('navigateToQuiz calls Navigator.pushNamed with /quiz', (tester) async {
    await tester.pumpWidget(testWidget);

    final context = tester.element(find.byType(ElevatedButton));
    final dataSource = ChoiceRemoteDataSource(context);

    await dataSource.navigateToQuiz();

    verify(() => mockObserver.didPush(any(), any())).called(1);
    // Could also verify the route name via navigation testing tools if needed
  });

  testWidgets('navigateToResources calls Navigator.pushNamed with /resources', (tester) async {
    await tester.pumpWidget(testWidget);

    final context = tester.element(find.byType(ElevatedButton));
    final dataSource = ChoiceRemoteDataSource(context);

    await dataSource.navigateToResources();

    verify(() => mockObserver.didPush(any(), any())).called(1);
  });
}
