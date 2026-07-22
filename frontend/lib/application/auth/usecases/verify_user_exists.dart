import '../../../domain/auth/repositories/auth_repository.dart';

class CheckUsernameExistsUseCase {
  final UserRepository repository;

  CheckUsernameExistsUseCase(this.repository);

  Future<bool> call(String username) async {
    return await repository.doesUserExist(username);
  }
}
