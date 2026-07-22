import '../../../domain/user_list/repositories/user_repository.dart';

class RemoveUser {
  final UserRepository repository;

  RemoveUser(this.repository);

  Future<void> call(String id) {
    return repository.removeUser(id);
  }
}
