import '../../../domain/user_list/entities/user.dart';
import '../../../domain/user_list/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<User>> call() {
    return repository.fetchUsers();
  }
}
