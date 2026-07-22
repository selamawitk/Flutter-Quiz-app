import 'package:dartz/dartz.dart';
import '../../../domain/forgot_password/entities/forgot_password.dart';
import '../../../domain/forgot_password/repositories/forgot_password_repository.dart';

class SendPasswordResetLink {
  final ForgotPasswordRepository repository;

  SendPasswordResetLink(this.repository);

  Future<Either<String, ForgotPassword>> call(String username) async {
    // Validate username
    if (username.trim().isEmpty) {
      return const Left('Username cannot be empty');
    }

    // Check if user exists
    final userResult = await repository.getUserByUsername(username);
    if (userResult.isLeft()) {
      return userResult.fold(
        (error) => Left('User not found: $error'),
        (user) => const Left('User not found'),
      );
    }

    // Send reset link
    return await repository.sendPasswordResetLink(username);
  }
} 