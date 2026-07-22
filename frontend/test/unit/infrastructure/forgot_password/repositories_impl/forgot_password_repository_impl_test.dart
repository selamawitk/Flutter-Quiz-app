import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/domain/forgot_password/entities/forgot_password.dart';
import 'package:frontend/infrastructure/forgot_password/datasources/forgot_password_remote_data_source.dart';
import 'package:frontend/infrastructure/forgot_password/repositories_impl/forgot_password_repository_impl.dart';

class MockForgotPasswordRemoteDataSource extends Mock implements ForgotPasswordRemoteDataSource {}

void main() {
  late ForgotPasswordRepositoryImpl repository;
  late MockForgotPasswordRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockForgotPasswordRemoteDataSource();
    repository = ForgotPasswordRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('ForgotPasswordRepositoryImpl', () {
    const testUsername = 'testuser';
    const testToken = 'reset-token-123';
    final testForgotPassword = ForgotPassword(
      username: testUsername,
      email: 'test@example.com',
      resetToken: testToken,
      requestTime: DateTime.parse('2023-12-01T10:00:00Z'),
      isTokenValid: true,
    );

    group('sendPasswordResetLink', () {
      test('should return Right(ForgotPassword) when remote data source succeeds', () async {
        // arrange
        when(() => mockRemoteDataSource.sendPasswordResetLink(any()))
            .thenAnswer((_) async => testForgotPassword);

        // act
        final result = await repository.sendPasswordResetLink(testUsername);

        // assert
        expect(result, Right(testForgotPassword));
        verify(() => mockRemoteDataSource.sendPasswordResetLink(testUsername));
      });

      test('should return Left(error) when remote data source throws exception', () async {
        // arrange
        when(() => mockRemoteDataSource.sendPasswordResetLink(any()))
            .thenThrow(Exception('Failed to send reset link'));

        // act
        final result = await repository.sendPasswordResetLink(testUsername);

        // assert
        expect(result.isLeft(), true);
        verify(() => mockRemoteDataSource.sendPasswordResetLink(testUsername));
      });
    });

    group('validateResetLink', () {
      test('should return Right(true) when token is valid', () async {
        // arrange
        when(() => mockRemoteDataSource.validateResetLink(any()))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.validateResetLink(testToken);

        // assert
        expect(result, const Right(true));
        verify(() => mockRemoteDataSource.validateResetLink(testToken));
      });

      test('should return Left(error) when remote data source throws exception', () async {
        // arrange
        when(() => mockRemoteDataSource.validateResetLink(any()))
            .thenThrow(Exception('Token validation failed'));

        // act
        final result = await repository.validateResetLink(testToken);

        // assert
        expect(result.isLeft(), true);
        verify(() => mockRemoteDataSource.validateResetLink(testToken));
      });
    });

    group('getUserByUsername', () {
      test('should return Right(ForgotPassword) when user is found', () async {
        // arrange
        when(() => mockRemoteDataSource.getUserByUsername(any()))
            .thenAnswer((_) async => testForgotPassword);

        // act
        final result = await repository.getUserByUsername(testUsername);

        // assert
        expect(result, Right(testForgotPassword));
        verify(() => mockRemoteDataSource.getUserByUsername(testUsername));
      });

      test('should return Left(error) when user is not found', () async {
        // arrange
        when(() => mockRemoteDataSource.getUserByUsername(any()))
            .thenThrow(Exception('User not found'));

        // act
        final result = await repository.getUserByUsername(testUsername);

        // assert
        expect(result.isLeft(), true);
        verify(() => mockRemoteDataSource.getUserByUsername(testUsername));
      });
    });
  });
} 