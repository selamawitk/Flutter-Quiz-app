import 'package:dartz/dartz.dart';
import '../../../domain/reset_password/entities/reset_password.dart';
import '../../../domain/reset_password/repositories/reset_password_repository.dart';

class ResetUserPassword {
  final ResetPasswordRepository repository;

  ResetUserPassword(this.repository);

  Future<Either<String, bool>> call(ResetPassword resetPassword) async {
    // Validate passwords match
    if (resetPassword.newPassword != resetPassword.confirmPassword) {
      return const Left('Passwords do not match');
    }

    // Validate password strength
    if (resetPassword.newPassword.length < 6) {
      return const Left('Password must be at least 6 characters long');
    }

    // Validate token if provided
    if (resetPassword.token != null) {
      final tokenValidation = await repository.validateResetToken(resetPassword.token!);
      if (tokenValidation.isLeft()) {
        return tokenValidation.fold(
          (error) => Left('Invalid reset token: $error'),
          (isValid) => const Left('Invalid reset token'),
        );
      }
    }

    return await repository.resetPassword(resetPassword);
  }
} 