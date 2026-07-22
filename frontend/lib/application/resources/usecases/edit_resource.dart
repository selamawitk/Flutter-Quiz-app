import '../../../domain/resources/repositories/resource_repository.dart';

class EditResource {
  final ResourceRepository repository;

  EditResource(this.repository);

  Future<void> call(String id) async {
    await repository.editResource(id);
  }
}
