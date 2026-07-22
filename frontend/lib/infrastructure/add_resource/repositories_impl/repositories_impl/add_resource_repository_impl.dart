import 'package:frontend/domain/add_resource/repositories/add_resource_repository.dart';
import 'package:frontend/domain/core/failures/app_failure.dart';
import 'package:dartz/dartz.dart';

// Fix this line - ensure NO spaces within the quotes, only characters forming the path
import '../../datasources/add_resource_remote_data_source.dart';

class AddResourceRepositoryImpl implements AddResourceRepository {
  final AddResourceRemoteDataSource remoteDataSource;

  AddResourceRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppFailure, Unit>> createResource({
    required String title,
    required String description,
    required String link,
  }) async {
    try {
      await remoteDataSource.createResource(
        title: title,
        description: description,
        link: link,
      );
      return right(unit);
    } catch (e) {
      // Assuming AppFailure.serverError is a constructor you've defined or will define.
      // If not, you might need to adjust how you create the AppFailure here.
      return left(AppFailure.serverError(e.toString()));
    }
  }
}
