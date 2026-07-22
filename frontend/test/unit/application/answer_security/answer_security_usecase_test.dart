import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/domain/answer_security/entities/answer_security.dart';
import 'package:frontend/domain/answer_security/repositories/answer_security_repository.dart';
import 'package:frontend/application/answer_security/usecases/verify_security_answer.dart';

class MockAnswerSecurityRepository extends Mock implements AnswerSecurityRepository {}

void main() {
  late VerifySecurityAnswer usecase;
  late MockAnswerSecurityRepository mockRepository;

  setUp(() {
    mockRepository = MockAnswerSecurityRepository();
    usecase = VerifySecurityAnswer(mockRepository);
  });

  group('VerifySecurityAnswer', () {
    const testUsername = 'testuser';
    const testAnswer = 'Smith';
    const testQuestion = 'What is your mother\'s maiden name?';
    const testAnswerSecurity = AnswerSecurity(
      username: testUsername,
      securityQuestion: testQuestion,
      securityAnswer: testAnswer,
      isVerified: true,
      verificationToken: 'verification-token-123',
    );

    test('should verify security answer successfully when input is valid', () async {
      // arrange
      when(() => mockRepository.getSecurityQuestion(testUsername))
          .thenAnswer((_) async => const Right(testQuestion));
      when(() => mockRepository.verifySecurityAnswer(testUsername, testAnswer))
          .thenAnswer((_) async => const Right(testAnswerSecurity));

      // act
      final result = await usecase(testUsername, testAnswer);

      // assert
      expect(result, const Right(testAnswerSecurity));
      verify(() => mockRepository.getSecurityQuestion(testUsername));
      verify(() => mockRepository.verifySecurityAnswer(testUsername, testAnswer));
    });

    test('should return error when username is empty', () async {
      // act
      final result = await usecase('', testAnswer);

      // assert
      expect(result, const Left('Username cannot be empty'));
      verifyNever(() => mockRepository.getSecurityQuestion(any()));
      verifyNever(() => mockRepository.verifySecurityAnswer(any(), any()));
    });

    test('should return error when username contains only whitespace', () async {
      // act
      final result = await usecase('   ', testAnswer);

      // assert
      expect(result, const Left('Username cannot be empty'));
      verifyNever(() => mockRepository.getSecurityQuestion(any()));
      verifyNever(() => mockRepository.verifySecurityAnswer(any(), any()));
    });

    test('should return error when answer is empty', () async {
      // act
      final result = await usecase(testUsername, '');

      // assert
      expect(result, const Left('Security answer cannot be empty'));
      verifyNever(() => mockRepository.getSecurityQuestion(any()));
      verifyNever(() => mockRepository.verifySecurityAnswer(any(), any()));
    });

    test('should return error when answer contains only whitespace', () async {
      // act
      final result = await usecase(testUsername, '   ');

      // assert
      expect(result, const Left('Security answer cannot be empty'));
      verifyNever(() => mockRepository.getSecurityQuestion(any()));
      verifyNever(() => mockRepository.verifySecurityAnswer(any(), any()));
    });

    test('should return error when security question cannot be retrieved', () async {
      // arrange
      when(() => mockRepository.getSecurityQuestion(testUsername))
          .thenAnswer((_) async => const Left('User not found'));

      // act
      final result = await usecase(testUsername, testAnswer);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (error) => expect(error, contains('Failed to retrieve security question')),
        (success) => fail('Should have returned error'),
      );
      verify(() => mockRepository.getSecurityQuestion(testUsername));
      verifyNever(() => mockRepository.verifySecurityAnswer(any(), any()));
    });

    test('should return error when answer verification fails', () async {
      // arrange
      when(() => mockRepository.getSecurityQuestion(testUsername))
          .thenAnswer((_) async => const Right(testQuestion));
      when(() => mockRepository.verifySecurityAnswer(testUsername, testAnswer))
          .thenAnswer((_) async => const Left('Incorrect answer'));

      // act
      final result = await usecase(testUsername, testAnswer);

      // assert
      expect(result, const Left('Incorrect answer'));
      verify(() => mockRepository.getSecurityQuestion(testUsername));
      verify(() => mockRepository.verifySecurityAnswer(testUsername, testAnswer));
    });

    test('should trim whitespace from answer', () async {
      // arrange
      const answerWithSpaces = '  Smith  ';
      when(() => mockRepository.getSecurityQuestion(testUsername))
          .thenAnswer((_) async => const Right(testQuestion));
      when(() => mockRepository.verifySecurityAnswer(testUsername, 'Smith'))
          .thenAnswer((_) async => const Right(testAnswerSecurity));

      // act
      final result = await usecase(testUsername, answerWithSpaces);

      // assert
      expect(result, const Right(testAnswerSecurity));
      verify(() => mockRepository.getSecurityQuestion(testUsername));
      verify(() => mockRepository.verifySecurityAnswer(testUsername, 'Smith'));
    });
  });
} 