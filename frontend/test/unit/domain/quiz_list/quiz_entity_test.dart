import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/quiz_list/entities/quiz.dart';

void main() {
  group('Quiz Entity', () {
    test('should hold correct values', () {
      const quiz = Quiz(id: 'q1', title: 'Mathematics Quiz');
      expect(quiz.id, 'q1');
      expect(quiz.title, 'Mathematics Quiz');
    });

    test('should support value equality', () {
      const quiz1 = Quiz(id: 'q1', title: 'Mathematics Quiz');
      const quiz2 = Quiz(id: 'q1', title: 'Mathematics Quiz');
      const quiz3 = Quiz(id: 'q2', title: 'Science Quiz');

      expect(quiz1, equals(quiz2));
      expect(quiz1 == quiz2, isTrue);
      expect(quiz1, isNot(equals(quiz3)));
      expect(quiz1 == quiz3, isFalse);
    });
  });
}

