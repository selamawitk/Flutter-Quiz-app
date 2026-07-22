import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/domain/forgot_password/entities/forgot_password.dart';
import 'package:frontend/domain/forgot_password/repositories/forgot_password_repository.dart';
import 'package:frontend/application/forgot_password/usecases/send_password_reset_link.dart';

class MockForgotPasswordRepository extends Mock implements ForgotPasswordRepository {}

void main() {
  late SendPasswordResetLink usecase;
  late MockForgotPasswordRepository mockRepository;

  setUp(() {
    mockRepository = MockForgotPasswordRepository();
    usecase = SendPasswordResetLink(mockRepository);
  });

  group('SendPasswordResetLink', () {
    const testUsername = 'testuser';
    final testForgotPassword = ForgotPassword(
      username: testUsername,
      email: 'test@example.com',
      resetToken: 'reset-token-123',
      requestTime: DateTime.now(),
      isTokenValid: true,
    );

    test('should send reset link successfully when user exists', () async {
      // arrange
      when(() => mockRepository.getUserByUsername(testUsername))
          .thenAnswer((_) async => Right(testForgotPassword));
      when(() => mockRepository.sendPasswordResetLink(testUsername))
          .thenAnswer((_) async => Right(testForgotPassword));

      // act
      final result = await usecase(testUsername);

      // assert
      expect(result, Right(testForgotPassword));
      verify(() => mockRepository.getUserByUsername(testUsername));
      verify(() => mockRepository.sendPasswordResetLink(testUsername));
    });

    test('should return error when username is empty', () async {
      // act
      final result = await usecase('');

      // assert
      expect(result, const Left('Username cannot be empty'));
      verifyNever(() => mockRepository.getUserByUsername(any()));
      verifyNever(() => mockRepository.sendPasswordResetLink(any()));
    });

    test('should return error when username contains only whitespace', () async {
      // act
      final result = await usecase('   ');

      // assert
      expect(result, const Left('Username cannot be empty'));
      verifyNever(() => mockRepository.getUserByUsername(any()));
      verifyNever(() => mockRepository.sendPasswordResetLink(any()));
    });

    test('should return error when user does not exist', () async {
      // arrange
      when(() => mockRepository.getUserByUsername(testUsername))
          .thenAnswer((_) async => const Left('User not found'));

      // act
      final result = await usecase(testUsername);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (error) => expect(error, contains('User not found')),
        (success) => fail('Should have returned error'),
      );
      verify(() => mockRepository.getUserByUsername(testUsername));
      verifyNever(() => mockRepository.sendPasswordResetLink(any()));
    });

    test('should return error when sending reset link fails', () async {
      // arrange
      when(() => mockRepository.getUserByUsername(testUsername))
          .thenAnswer((_) async => Right(testForgotPassword));
      when(() => mockRepository.sendPasswordResetLink(testUsername))
          .thenAnswer((_) async => const Left('Email service unavailable'));

      // act
      final result = await usecase(testUsername);

      // assert
      expect(result, const Left('Email service unavailable'));
      verify(() => mockRepository.getUserByUsername(testUsername));
      verify(() => mockRepository.sendPasswordResetLink(testUsername));
    });

    test('should trim whitespace from username', () async {
      // arrange
      const usernameWithSpaces = '  testuser  ';
      when(() => mockRepository.getUserByUsername('testuser'))
          .thenAnswer((_) async => Right(testForgotPassword));
      when(() => mockRepository.sendPasswordResetLink('testuser'))
          .thenAnswer((_) async => Right(testForgotPassword));

      // act
      final result = await usecase(usernameWithSpaces);

      // assert
      expect(result, Right(testForgotPassword));
      verify(() => mockRepository.getUserByUsername('testuser'));
      verify(() => mockRepository.sendPasswordResetLink('testuser'));
    });
  });
} 