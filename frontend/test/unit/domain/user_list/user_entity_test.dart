import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/user_list/entities/user.dart';

void main() {
  group('User Entity', () {
    test('should hold correct values', () {
      const user = User(id: 'u1', name: 'John Doe');
      expect(user.id, 'u1');
      expect(user.name, 'John Doe');
    });

    test('should support value equality', () {
      const user1 = User(id: 'u1', name: 'John Doe');
      const user2 = User(id: 'u1', name: 'John Doe');
      const user3 = User(id: 'u2', name: 'Jane Smith');

      expect(user1, equals(user2));
      expect(user1 == user2, isTrue);
      expect(user1, isNot(equals(user3)));
      expect(user1 == user3, isFalse);
    });
  });
}

