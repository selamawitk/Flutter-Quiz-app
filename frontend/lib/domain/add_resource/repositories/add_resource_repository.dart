import '../../core/failures/app_failure.dart';
import 'package:dartz/dartz.dart';

abstract class AddResourceRepository {
  Future<Either<AppFailure, Unit>> createResource({
    required String title,
    required String description,
    required String link,
  });
}