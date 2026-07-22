import '../../../domain/user_list/entities/user.dart';
import '../../../domain/user_list/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<User>> fetchUsers() {
    return remoteDataSource.getUsers();
  }

  @override
  Future<void> removeUser(String id) {
    return remoteDataSource.deleteUser(id);
  }
}
