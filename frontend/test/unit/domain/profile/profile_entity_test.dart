// test/unit/domain/profile/profile_entity_test.dart

import 'package:flutter_test/flutter_test.dart';

// Example domain entity (replace with your real entity)
class ProfileEntity {
  final String name;
  ProfileEntity(this.name);
}

void main() {
  group('ProfileEntity', () {
    test('should correctly store and retrieve name', () {
      final profile = ProfileEntity('ሰላማዊት');
      expect(profile.name, 'ሰላማዊት');
    });
  });
}
