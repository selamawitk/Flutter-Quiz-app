import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:frontend/domain/answer_security/entities/answer_security.dart';
import 'package:frontend/infrastructure/answer_security/datasources/answer_security_remote_data_source.dart';
import 'package:frontend/infrastructure/answer_security/repositories_impl/answer_security_repository_impl.dart';

class MockAnswerSecurityRemoteDataSource extends Mock implements AnswerSecurityRemoteDataSource {}

void main() {
  late AnswerSecurityRepositoryImpl repository;
  late MockAnswerSecurityRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockAnswerSecurityRemoteDataSource();
    repository = AnswerSecurityRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('AnswerSecurityRepositoryImpl', () {
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

    group('verifySecurityAnswer', () {
      test('should return Right(AnswerSecurity) when remote data source succeeds', () async {
        // arrange
        when(() => mockRemoteDataSource.verifySecurityAnswer(any(), any()))
            .thenAnswer((_) async => testAnswerSecurity);

        // act
        final result = await repository.verifySecurityAnswer(testUsername, testAnswer);

        // assert
        expect(result, const Right(testAnswerSecurity));
        verify(() => mockRemoteDataSource.verifySecurityAnswer(testUsername, testAnswer));
      });

      test('should return Left(error) when remote data source throws exception', () async {
        // arrange
        when(() => mockRemoteDataSource.verifySecurityAnswer(any(), any()))
            .thenThrow(Exception('Verification failed'));

        // act
        final result = await repository.verifySecurityAnswer(testUsername, testAnswer);

        // assert
        expect(result.isLeft(), true);
        verify(() => mockRemoteDataSource.verifySecurityAnswer(testUsername, testAnswer));
      });
    });

    group('getSecurityQuestion', () {
      test('should return Right(question) when remote data source succeeds', () async {
        // arrange
        when(() => mockRemoteDataSource.getSecurityQuestion(any()))
            .thenAnswer((_) async => testQuestion);

        // act
        final result = await repository.getSecurityQuestion(testUsername);

        // assert
        expect(result, const Right(testQuestion));
        verify(() => mockRemoteDataSource.getSecurityQuestion(testUsername));
      });

      test('should return Left(error) when remote data source throws exception', () async {
        // arrange
        when(() => mockRemoteDataSource.getSecurityQuestion(any()))
            .thenThrow(Exception('User not found'));

        // act
        final result = await repository.getSecurityQuestion(testUsername);

        // assert
        expect(result.isLeft(), true);
        verify(() => mockRemoteDataSource.getSecurityQuestion(testUsername));
      });
    });

    group('updateSecurityQuestion', () {
      test('should return Right(true) when remote data source succeeds', () async {
        // arrange
        when(() => mockRemoteDataSource.updateSecurityQuestion(any(), any(), any()))
            .thenAnswer((_) async => true);

        // act
        final result = await repository.updateSecurityQuestion(testUsername, testQuestion, testAnswer);

        // assert
        expect(result, const Right(true));
        verify(() => mockRemoteDataSource.updateSecurityQuestion(testUsername, testQuestion, testAnswer));
      });

      test('should return Left(error) when remote data source throws exception', () async {
        // arrange
        when(() => mockRemoteDataSource.updateSecurityQuestion(any(), any(), any()))
            .thenThrow(Exception('Update failed'));

        // act
        final result = await repository.updateSecurityQuestion(testUsername, testQuestion, testAnswer);

        // assert
        expect(result.isLeft(), true);
        verify(() => mockRemoteDataSource.updateSecurityQuestion(testUsername, testQuestion, testAnswer));
      });
    });
  });
} 