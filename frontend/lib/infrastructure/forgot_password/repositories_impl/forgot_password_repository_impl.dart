import 'package:dartz/dartz.dart';
import '../../../domain/forgot_password/entities/forgot_password.dart';
import '../../../domain/forgot_password/repositories/forgot_password_repository.dart';
import '../datasources/forgot_password_remote_data_source.dart';

class ForgotPasswordRepositoryImpl implements ForgotPasswordRepository {
  final ForgotPasswordRemoteDataSource remoteDataSource;

  ForgotPasswordRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, ForgotPassword>> sendPasswordResetLink(String username) async {
    try {
      final result = await remoteDataSource.sendPasswordResetLink(username);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, bool>> validateResetLink(String token) async {
    try {
      final result = await remoteDataSource.validateResetLink(token);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, ForgotPassword>> getUserByUsername(String username) async {
    try {
      final result = await remoteDataSource.getUserByUsername(username);
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }
} 