import '../../../domain/auth/repositories/auth_repository.dart';

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<bool> call({
    required String username,
    required String newPassword,
    required String resetToken,
  }) async {
    return await repository.resetPassword(
      username: username,
      newPassword: newPassword,
      resetToken: resetToken,
    );
  }
} 