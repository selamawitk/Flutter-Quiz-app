import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/auth/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    test('should correctly instantiate with username', () {
      final user = UserEntity(username: 'testuser');

      expect(user.username, equals('testuser'));
    });
  });
}
