import '../../../domain/resources/entities/resource.dart';
import '../../../domain/resources/repositories/resource_repository.dart';

class GetResources {
  final ResourceRepository repository;

  GetResources(this.repository);

  Future<List<Resource>> call() async {
    return await repository.getResources();
  }
}
