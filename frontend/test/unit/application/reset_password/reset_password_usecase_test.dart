import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/domain/reset_password/entities/reset_password.dart';
import 'package:frontend/domain/reset_password/repositories/reset_password_repository.dart';
import 'package:frontend/application/reset_password/usecases/reset_user_password.dart';

class MockResetPasswordRepository extends Mock implements ResetPasswordRepository {}

void main() {
  late ResetUserPassword usecase;
  late MockResetPasswordRepository mockRepository;

  setUp(() {
    mockRepository = MockResetPasswordRepository();
    usecase = ResetUserPassword(mockRepository);
  });

  group('ResetUserPassword', () {
    const testResetPassword = ResetPassword(
      username: 'testuser',
      newPassword: 'newPassword123',
      confirmPassword: 'newPassword123',
      token: 'valid-token',
    );

    test('should reset password successfully when input is valid', () async {
      // arrange
      when(() => mockRepository.validateResetToken(any()))
          .thenAnswer((_) async => const Right(true));
      when(() => mockRepository.resetPassword(any()))
          .thenAnswer((_) async => const Right(true));

      // act
      final result = await usecase(testResetPassword);

      // assert
      expect(result, const Right(true));
      verify(() => mockRepository.validateResetToken('valid-token'));
      verify(() => mockRepository.resetPassword(testResetPassword));
    });

    test('should return error when passwords do not match', () async {
      // arrange
      const invalidResetPassword = ResetPassword(
        username: 'testuser',
        newPassword: 'password1',
        confirmPassword: 'password2',
      );

      // act
      final result = await usecase(invalidResetPassword);

      // assert
      expect(result, const Left('Passwords do not match'));
      verifyNever(() => mockRepository.resetPassword(any()));
    });

    test('should return error when password is too short', () async {
      // arrange
      const invalidResetPassword = ResetPassword(
        username: 'testuser',
        newPassword: '123',
        confirmPassword: '123',
      );

      // act
      final result = await usecase(invalidResetPassword);

      // assert
      expect(result, const Left('Password must be at least 6 characters long'));
      verifyNever(() => mockRepository.resetPassword(any()));
    });

    test('should return error when reset token is invalid', () async {
      // arrange
      when(() => mockRepository.validateResetToken(any()))
          .thenAnswer((_) async => const Left('Invalid token'));

      // act
      final result = await usecase(testResetPassword);

      // assert
      expect(result.isLeft(), true);
      result.fold(
        (error) => expect(error, contains('Invalid reset token')),
        (success) => fail('Should have returned error'),
      );
      verify(() => mockRepository.validateResetToken('valid-token'));
      verifyNever(() => mockRepository.resetPassword(any()));
    });

    test('should reset password without token validation when token is null', () async {
      // arrange
      const resetPasswordWithoutToken = ResetPassword(
        username: 'testuser',
        newPassword: 'newPassword123',
        confirmPassword: 'newPassword123',
      );
      when(() => mockRepository.resetPassword(any()))
          .thenAnswer((_) async => const Right(true));

      // act
      final result = await usecase(resetPasswordWithoutToken);

      // assert
      expect(result, const Right(true));
      verifyNever(() => mockRepository.validateResetToken(any()));
      verify(() => mockRepository.resetPassword(resetPasswordWithoutToken));
    });

    test('should return error when repository fails', () async {
      // arrange
      when(() => mockRepository.validateResetToken(any()))
          .thenAnswer((_) async => const Right(true));
      when(() => mockRepository.resetPassword(any()))
          .thenAnswer((_) async => const Left('Server error'));

      // act
      final result = await usecase(testResetPassword);

      // assert
      expect(result, const Left('Server error'));
      verify(() => mockRepository.resetPassword(testResetPassword));
    });
  });
} 