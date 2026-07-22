import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/presentation/user_list/user_list_controller.dart';

void main() {
  group('usersProvider tests', () {
    test('initial users list contains 7 elements named User1', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final users = container.read(usersProvider);
      expect(users.length, 7);
      for (final user in users) {
        expect(user, 'User1');
      }
    });

    test('removing a user updates the usersProvider state correctly', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Initially 7 users
      expect(container.read(usersProvider).length, 7);

      // Remove user at index 0
      final updatedUsers = [...container.read(usersProvider)]..removeAt(0);
      container.read(usersProvider.notifier).state = updatedUsers;

      final newUsers = container.read(usersProvider);
      expect(newUsers.length, 6);
    });
  });
}

