import '../../application/auth/usecases/verify_user_exists.dart';

class ForgotPasswordController {
  final CheckUsernameExistsUseCase checkUsernameExistsUseCase;

  ForgotPasswordController(this.checkUsernameExistsUseCase);

  Future<bool> verifyUsername(String username) async {
    return await checkUsernameExistsUseCase(username);
  }
}
