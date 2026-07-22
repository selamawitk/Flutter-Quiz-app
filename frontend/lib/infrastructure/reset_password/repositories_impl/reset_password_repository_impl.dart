import 'package:dartz/dartz.dart';
import '../../../domain/reset_password/entities/reset_password.dart';
import '../../../domain/reset_password/repositories/reset_password_repository.dart';
import '../datasources/reset_password_remote_data_source.dart';

class ResetPasswordRepositoryImpl implements ResetPasswordRepository {
  final ResetPasswordRemoteDataSource remoteDataSource;

  ResetPasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, bool>> resetPassword(ResetPassword resetPassword) async {
    try {
      final result = await remoteDataSource.resetPassword(resetPassword);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> validateResetToken(String token) async {
    try {
      final result = await remoteDataSource.validateResetToken(token);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> generateResetToken(String username) async {
    try {
      final result = await remoteDataSource.generateResetToken(username);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
} 