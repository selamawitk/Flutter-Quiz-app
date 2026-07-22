import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/presentation/choice/choice_page.dart';
import 'package:frontend/presentation/choice/choice_controller.dart';
import 'package:frontend/application/choice/usecases/go_to_quiz.dart';
import 'package:frontend/application/choice/usecases/go_to_resources.dart';
import 'package:frontend/domain/choice/repositories/choice_repository.dart';

// Fake repository implementing ChoiceRepository with required methods
class FakeChoiceRepository implements ChoiceRepository {
  @override
  Future<void> goToQuiz() async {
    // no-op or simulate behavior
  }

  @override
  Future<void> goToResources() async {
    // no-op or simulate behavior
  }
}

// Mock GoToQuiz usecase that records if called
class MockGoToQuiz extends GoToQuiz {
  bool called = false;

  MockGoToQuiz() : super(FakeChoiceRepository());

  @override
  Future<void> call() async {
    called = true;
  }
}

// Mock GoToResources usecase that records if called
class MockGoToResources extends GoToResources {
  bool called = false;

  MockGoToResources() : super(FakeChoiceRepository());

  @override
  Future<void> call() async {
    called = true;
  }
}

// Mock controller that uses the mocked usecases
class MockChoiceController extends ChoiceController {
  final MockGoToQuiz mockGoToQuiz;
  final MockGoToResources mockGoToResources;

  MockChoiceController()
      : mockGoToQuiz = MockGoToQuiz(),
        mockGoToResources = MockGoToResources(),
        super(MockGoToQuiz(), MockGoToResources());

  @override
  void onQuizPressed() {
    mockGoToQuiz.call();
  }

  @override
  void onResourcePressed() {
    mockGoToResources.call();
  }
}

void main() {
  testWidgets('ChoiceScreen renders and buttons work', (WidgetTester tester) async {
    final mockController = MockChoiceController();

    final container = ProviderContainer(overrides: [
      choiceControllerProvider.overrideWithProvider(
        Provider.family<ChoiceController, BuildContext>((ref, context) => mockController),
      ),
    ]);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(
          home: ChoiceScreen(),
        ),
      ),
    );

    final quizButton = find.widgetWithText(ElevatedButton, 'ፈተና');
    final resourceButton = find.widgetWithText(ElevatedButton, 'ጥናት');

    expect(quizButton, findsOneWidget);
    expect(resourceButton, findsOneWidget);

    await tester.tap(quizButton);
    await tester.pumpAndSettle();
    expect(mockController.mockGoToQuiz.called, true);

    await tester.tap(resourceButton);
    await tester.pumpAndSettle();
    expect(mockController.mockGoToResources.called, true);
  });
}
