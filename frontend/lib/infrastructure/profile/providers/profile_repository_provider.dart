import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/profile/repositories/profile_repository.dart';
import '../datasources/profile_remote_data_source.dart';
import '../repositories_impl/profile_repository_impl.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dataSource = ProfileRemoteDataSourceImpl();
  return ProfileRepositoryImpl(remoteDataSource: dataSource);
});
