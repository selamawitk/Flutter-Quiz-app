// test/unit/infrastructure/profile/datasources/profile_remote_data_source_test.dart

import 'package:flutter_test/flutter_test.dart';

class ProfileRemoteDataSource {
  Future<String> getProfileName() async {
    return Future.value('ሰላማዊት');
  }
}

void main() {
  group('ProfileRemoteDataSource', () {
    late ProfileRemoteDataSource dataSource;

    setUp(() {
      dataSource = ProfileRemoteDataSource();
    });

    test('should return profile name from remote source', () async {
      final name = await dataSource.getProfileName();
      expect(name, 'ሰላማዊት');
    });
  });
}
