import 'package:dartz/dartz.dart';
import '../../../domain/answer_security/entities/answer_security.dart';
import '../../../domain/answer_security/repositories/answer_security_repository.dart';
import '../datasources/answer_security_remote_data_source.dart';

class AnswerSecurityRepositoryImpl implements AnswerSecurityRepository {
  final AnswerSecurityRemoteDataSource remoteDataSource;

  AnswerSecurityRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, AnswerSecurity>> verifySecurityAnswer(
    String username, 
    String answer
  ) async {
    try {
      final result = await remoteDataSource.verifySecurityAnswer(username, answer);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> getSecurityQuestion(String username) async {
    try {
      final result = await remoteDataSource.getSecurityQuestion(username);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> updateSecurityQuestion(
    String username, 
    String question, 
    String answer
  ) async {
    try {
      final result = await remoteDataSource.updateSecurityQuestion(username, question, answer);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
} 