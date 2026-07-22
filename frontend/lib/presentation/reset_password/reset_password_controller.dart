import '../../application/auth/usecases/reset_password.dart';

class ResetPasswordController {
  final ResetPasswordUseCase resetPasswordUseCase;
  final String username;
  final String resetToken;

  ResetPasswordController(this.resetPasswordUseCase, this.username, this.resetToken);

  Future<bool> resetPassword(String newPassword) async {
    return await resetPasswordUseCase(
      username: username,
      newPassword: newPassword,
      resetToken: resetToken,
    );
  }
} 