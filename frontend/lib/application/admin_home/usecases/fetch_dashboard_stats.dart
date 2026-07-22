import 'package:dartz/dartz.dart';
import '../../../domain/core/failures/app_failure.dart';
import '../../../domain/admin_home/entities/admin_stats.dart';
import '../../../domain/admin_home/repositories/admin_home_repository.dart';

class FetchDashboardStatsUseCase {
  final AdminHomeRepository repository;

  FetchDashboardStatsUseCase(this.repository);

  Future<Either<AppFailure, DashboardStats>> call() async {
    return await repository.fetchDashboardStats();
  }
}
