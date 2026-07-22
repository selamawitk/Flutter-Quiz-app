// test/unit/infrastructure/profile/repositories_impl/profile_repository_impl_test.dart

import 'package:flutter_test/flutter_test.dart';

class ProfileRepositoryImpl {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl(this.remoteDataSource);

  Future<String> getProfileName() {
    return remoteDataSource.getProfileName();
  }
}

class ProfileRemoteDataSource {
  Future<String> getProfileName() async => 'ሰላማዊት';
}

void main() {
  group('ProfileRepositoryImpl', () {
    late ProfileRemoteDataSource remoteDataSource;
    late ProfileRepositoryImpl repository;

    setUp(() {
      remoteDataSource = ProfileRemoteDataSource();
      repository = ProfileRepositoryImpl(remoteDataSource);
    });

    test('should get profile name from remote data source', () async {
      final name = await repository.getProfileName();
      expect(name, 'ሰላማዊት');
    });
  });
}
