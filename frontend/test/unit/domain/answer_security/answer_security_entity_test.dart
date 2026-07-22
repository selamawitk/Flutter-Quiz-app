import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/answer_security/entities/answer_security.dart';

void main() {
  group('AnswerSecurity Entity', () {
    const testAnswerSecurity = AnswerSecurity(
      username: 'testuser',
      securityQuestion: 'What is your mother\'s maiden name?',
      securityAnswer: 'Smith',
      isVerified: true,
      verificationToken: 'verification-token-123',
    );

    test('should be a subclass of Equatable', () {
      expect(testAnswerSecurity, isA<AnswerSecurity>());
    });

    test('should return correct props for equality comparison', () {
      expect(
        testAnswerSecurity.props,
        [
          'testuser',
          'What is your mother\'s maiden name?',
          'Smith',
          true,
          'verification-token-123'
        ],
      );
    });

    test('should create a copy with updated values', () {
      final updatedAnswerSecurity = testAnswerSecurity.copyWith(
        securityAnswer: 'Johnson',
        isVerified: false,
      );

      expect(updatedAnswerSecurity.username, 'testuser');
      expect(updatedAnswerSecurity.securityQuestion, 'What is your mother\'s maiden name?');
      expect(updatedAnswerSecurity.securityAnswer, 'Johnson');
      expect(updatedAnswerSecurity.isVerified, false);
      expect(updatedAnswerSecurity.verificationToken, 'verification-token-123');
    });

    test('should convert to JSON correctly', () {
      final json = testAnswerSecurity.toJson();

      expect(json, {
        'username': 'testuser',
        'securityQuestion': 'What is your mother\'s maiden name?',
        'securityAnswer': 'Smith',
        'isVerified': true,
        'verificationToken': 'verification-token-123',
      });
    });

    test('should create from JSON correctly', () {
      final json = {
        'username': 'testuser',
        'securityQuestion': 'What is your mother\'s maiden name?',
        'securityAnswer': 'Smith',
        'isVerified': true,
        'verificationToken': 'verification-token-123',
      };

      final answerSecurity = AnswerSecurity.fromJson(json);

      expect(answerSecurity, testAnswerSecurity);
    });

    test('should handle null verificationToken in JSON conversion', () {
      const answerSecurityWithoutToken = AnswerSecurity(
        username: 'testuser',
        securityQuestion: 'What is your favorite color?',
        securityAnswer: 'Blue',
      );

      final json = answerSecurityWithoutToken.toJson();

      expect(json, {
        'username': 'testuser',
        'securityQuestion': 'What is your favorite color?',
        'securityAnswer': 'Blue',
        'isVerified': false,
      });
      expect(json.containsKey('verificationToken'), false);
    });

    test('should create with default values', () {
      const answerSecurity = AnswerSecurity(
        username: 'testuser',
        securityQuestion: 'What is your pet\'s name?',
        securityAnswer: 'Fluffy',
      );

      expect(answerSecurity.username, 'testuser');
      expect(answerSecurity.securityQuestion, 'What is your pet\'s name?');
      expect(answerSecurity.securityAnswer, 'Fluffy');
      expect(answerSecurity.isVerified, false);
      expect(answerSecurity.verificationToken, null);
    });
  });
} 