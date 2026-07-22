import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/auth/entities/security_questions.dart';
import 'package:frontend/domain/auth/entities/user_entity.dart';

void main() {
  group('SecurityQuestions', () {
    test('should correctly instantiate with all values', () {
      final user = UserEntity(username: 'testuser');
      final securityQuestions = SecurityQuestions(
        user: user,
        question1: 'What is your pet’s name?',
        answer1: 'Fluffy',
        question2: 'What is your favorite color?',
        answer2: 'Blue',
      );

      expect(securityQuestions.user.username, equals('testuser'));
      expect(securityQuestions.question1, equals('What is your pet’s name?'));
      expect(securityQuestions.answer1, equals('Fluffy'));
      expect(securityQuestions.question2, equals('What is your favorite color?'));
      expect(securityQuestions.answer2, equals('Blue'));
    });
  });
}
