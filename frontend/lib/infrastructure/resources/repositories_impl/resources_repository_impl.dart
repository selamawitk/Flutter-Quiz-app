import 'package:frontend/domain/resources/entities/resource.dart';
import 'package:frontend/domain/resources/repositories/resource_repository.dart';
import '../datasources/resources_remote_data_source.dart';

class ResourcesRepositoryImpl implements ResourceRepository {
  final ResourcesRemoteDataSource remoteDataSource;

  ResourcesRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Resource>> getResources() async {
    return await remoteDataSource.getResources();
  }

  @override
  Future<void> removeResource(String id) async {
    await remoteDataSource.removeResource(id);
  }

  @override
  Future<void> editResource(String id) async {
    // TODO: implement editResource
  }
}
