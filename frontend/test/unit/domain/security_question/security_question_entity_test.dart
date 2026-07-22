import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/security_question/entities/security_question_entity.dart';

void main() {
  group('SecurityAnswers', () {
    test('should correctly instantiate with all fields', () {
      final answers = SecurityAnswers(
        question1: 'What is your favorite color?',
        answer1: 'Blue',
        question2: 'What is your pet’s name?',
        answer2: 'Max',
      );

      expect(answers.question1, equals('What is your favorite color?'));
      expect(answers.answer1, equals('Blue'));
      expect(answers.question2, equals('What is your pet’s name?'));
      expect(answers.answer2, equals('Max'));
    });
  });
}
