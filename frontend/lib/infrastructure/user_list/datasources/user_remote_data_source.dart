import 'package:dio/dio.dart';
import '../../../domain/user_list/entities/user.dart';
import '../../core/network/dio_client.dart';

abstract class UserRemoteDataSource {
  Future<List<User>> getUsers();
  Future<void> deleteUser(String id);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final DioClient dioClient;

  UserRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<User>> getUsers() async {
    try {
      final response = await dioClient.get('/auth/me');

      if (response.statusCode == 200) {
        final user = response.data['user'];
        if (user != null) {
          return [User(
            id: user['_id'] ?? user['id'] ?? '',
            name: user['username'] ?? '',
          )];
        }
      }
      return [];
    } on DioException {
      return [];
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> deleteUser(String id) async {
    // Backend does not support user deletion yet.
    // This is a no-op until the endpoint is added.
  }
}
