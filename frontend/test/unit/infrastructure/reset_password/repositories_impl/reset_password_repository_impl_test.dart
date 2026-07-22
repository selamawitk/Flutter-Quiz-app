import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/domain/reset_password/entities/reset_password.dart';
import 'package:frontend/infrastructure/reset_password/datasources/reset_password_remote_data_source.dart';
import 'package:frontend/infrastructure/reset_password/repositories_impl/reset_password_repository_impl.dart';

class MockResetPasswordRemoteDataSource extends Mock implements ResetPasswordRemoteDataSource {}

void main() {
  late ResetPasswordRepositoryImpl repository;
  late MockResetPasswordRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockResetPasswordRemoteDataSource();
    repository = ResetPasswordRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('ResetPasswordRepositoryImpl', () {
    const testResetPassword = ResetPassword(
      username: 'testuser',
      newPassword: 'newPassword123',
      confirmPassword: 'newPassword123',
      token: 'reset-token-123',
    );

    group('resetPassword', () {
      test('should return Right(true) when remote data source succeeds', () async {
        // arrange
        when(() => mockRemoteDataSource.resetPassword(testResetPassword))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.resetPassword(testResetPassword);

        // assert
        expect(result, const Right(true));
        verify(() => mockRemoteDataSource.resetPassword(testResetPassword));
      });

      test('should return Left(error) when remote data source throws exception', () async {
        // arrange
        when(() => mockRemoteDataSource.resetPassword(testResetPassword))
            .thenThrow(Exception('Network error'));

        // act
        final result = await repository.resetPassword(testResetPassword);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (error) => expect(error, contains('Exception: Network error')),
          (success) => fail('Should have returned error'),
        );
        verify(() => mockRemoteDataSource.resetPassword(testResetPassword));
      });
    });

    group('validateResetToken', () {
      const testToken = 'test-token-123';

      test('should return Right(true) when token is valid', () async {
        // arrange
        when(() => mockRemoteDataSource.validateResetToken(testToken))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.validateResetToken(testToken);

        // assert
        expect(result, const Right(true));
        verify(() => mockRemoteDataSource.validateResetToken(testToken));
      });

      test('should return Right(false) when token is invalid', () async {
        // arrange
        when(() => mockRemoteDataSource.validateResetToken(testToken))
            .thenAnswer((_) async => false);

        // act
        final result = await repository.validateResetToken(testToken);

        // assert
        expect(result, const Right(false));
        verify(() => mockRemoteDataSource.validateResetToken(testToken));
      });

      test('should return Left(error) when remote data source throws exception', () async {
        // arrange
        when(() => mockRemoteDataSource.validateResetToken(testToken))
            .thenThrow(Exception('Validation failed'));

        // act
        final result = await repository.validateResetToken(testToken);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (error) => expect(error, contains('Exception: Validation failed')),
          (success) => fail('Should have returned error'),
        );
        verify(() => mockRemoteDataSource.validateResetToken(testToken));
      });
    });

    group('generateResetToken', () {
      const testUsername = 'testuser';
      const testToken = 'generated-token-123';

      test('should return Right(token) when generation succeeds', () async {
        // arrange
        when(() => mockRemoteDataSource.generateResetToken(testUsername))
            .thenAnswer((_) async => testToken);

        // act
        final result = await repository.generateResetToken(testUsername);

        // assert
        expect(result, const Right(testToken));
        verify(() => mockRemoteDataSource.generateResetToken(testUsername));
      });

      test('should return Left(error) when remote data source throws exception', () async {
        // arrange
        when(() => mockRemoteDataSource.generateResetToken(testUsername))
            .thenThrow(Exception('Generation failed'));

        // act
        final result = await repository.generateResetToken(testUsername);

        // assert
        expect(result.isLeft(), true);
        result.fold(
          (error) => expect(error, contains('Exception: Generation failed')),
          (success) => fail('Should have returned error'),
        );
        verify(() => mockRemoteDataSource.generateResetToken(testUsername));
      });
    });
  });
} 