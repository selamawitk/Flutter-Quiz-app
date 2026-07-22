import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:frontend/application/quiz_list/usecases/get_quizzes.dart';
import 'package:frontend/domain/quiz_list/entities/quiz.dart';
import 'package:frontend/domain/quiz_list/repositories/quiz_repository.dart';
import 'package:frontend/presentation/quiz_list/quiz_list_page.dart';
import 'package:frontend/presentation/quiz_list/quiz_list_controller.dart';

void main() {
  testWidgets('displays quizzes in the list', (WidgetTester tester) async {
    final fakeQuizzes = [
      Quiz(id: '1', title: 'Math Quiz'),
      Quiz(id: '2', title: 'Science Quiz'),
    ];

    // Create the fake GetQuizzes that extends the real GetQuizzes
    final fakeGetQuizzes = FakeGetQuizzes(fakeQuizzes);

    final container = ProviderContainer(overrides: [
      quizListProvider.overrideWith(
            (ref) => QuizListControllerTest(fakeGetQuizzes, ref, fakeQuizzes),
      ),
    ]);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const MaterialApp(home: QuizListPage()),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Math Quiz'), findsOneWidget);
    expect(find.text('Science Quiz'), findsOneWidget);
  });
}

// Minimal fake repository implementation just to satisfy GetQuizzes constructor
class FakeQuizRepository implements QuizRepository {
  @override
  Future<List<Quiz>> getQuizzes() async => [];

  @override
  Future<void> removeQuiz(String id) async {}

// Implement any other methods if QuizRepository requires them
}

// FakeGetQuizzes must extend GetQuizzes to be assignable to GetQuizzes
class FakeGetQuizzes extends GetQuizzes {
  final List<Quiz> quizzes;

  FakeGetQuizzes(this.quizzes) : super(FakeQuizRepository());

  @override
  Future<List<Quiz>> call() async {
    return quizzes;
  }
}

// Test controller subclass that sets the state immediately to initial quizzes
class QuizListControllerTest extends QuizListController {
  QuizListControllerTest(
      super.getQuizzes, super.ref, List<Quiz> initialQuizzes) {
    state = initialQuizzes;
  }
}

