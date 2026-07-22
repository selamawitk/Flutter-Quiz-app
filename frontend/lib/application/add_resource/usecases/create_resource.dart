import 'package:dartz/dartz.dart';
import '../../../domain/add_resource/repositories/add_resource_repository.dart';
import '../../../domain/core/failures/app_failure.dart';

class CreateResourceUseCase {
  final AddResourceRepository repository;

  CreateResourceUseCase(this.repository);

  Future<Either<AppFailure, void>> call({
    required String title,
    required String description,
    required String link,
  }) async {
    return await repository.createResource(
      title: title,
      description: description,
      link: link,
    );
  }
}