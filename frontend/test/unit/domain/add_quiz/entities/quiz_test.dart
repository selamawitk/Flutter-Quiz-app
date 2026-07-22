import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/add_quiz/entities/quiz.dart';

void main() {
  test('Quiz entity should hold question and options', () {
    final quiz = Quiz(
      question: 'What is Flutter?',
      options: ['SDK', 'IDE', 'Programming Language', 'Database'],
    );

    expect(quiz.question, 'What is Flutter?');
    expect(quiz.options.length, 4);
  });
}

