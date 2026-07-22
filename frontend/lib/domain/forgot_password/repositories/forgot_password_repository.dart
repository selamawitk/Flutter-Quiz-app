import 'package:dartz/dartz.dart';
import '../entities/forgot_password.dart';

abstract class ForgotPasswordRepository {
  Future<Either<String, ForgotPassword>> sendPasswordResetLink(String username);
  Future<Either<String, bool>> validateResetLink(String token);
  Future<Either<String, ForgotPassword>> getUserByUsername(String username);
} 