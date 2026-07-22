import '../../../domain/user_list/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> getUsers();
  Future<void> deleteUser(String id);
}
