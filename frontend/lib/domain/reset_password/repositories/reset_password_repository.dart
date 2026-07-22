import 'package:dartz/dartz.dart';
import '../entities/reset_password.dart';

abstract class ResetPasswordRepository {
  Future<Either<String, bool>> resetPassword(ResetPassword resetPassword);
  Future<Either<String, bool>> validateResetToken(String token);
  Future<Either<String, String>> generateResetToken(String username);
} 