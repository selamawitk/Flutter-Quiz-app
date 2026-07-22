import '../../../domain/auth/repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<void> call({
    required String username,
    required String password,
    required String role,
  }) {
    return repository.login(username: username, password: password, role: role);
  }
}
