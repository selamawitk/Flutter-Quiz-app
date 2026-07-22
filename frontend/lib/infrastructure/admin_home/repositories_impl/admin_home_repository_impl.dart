import 'package:dartz/dartz.dart';
import 'package:frontend/domain/admin_home/repositories/admin_home_repository.dart';
import 'package:frontend/domain/core/failures/app_failure.dart';
import 'package:frontend/domain/admin_home/entities/admin_stats.dart';
import '../datasources/admin_home_remote_data_source.dart';

class AdminHomeRepositoryImpl implements AdminHomeRepository {
  final AdminHomeRemoteDataSource remoteDataSource;

  AdminHomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppFailure, DashboardStats>> fetchDashboardStats() async {
    try {
      final data = await remoteDataSource.fetchStats();
      // Direct conversion as entity_mapper is not present
      final dashboardStats = DashboardStats(
        totalUsers: data['totalUsers'] as int,
        totalQuizzes: data['totalQuizzes'] as int,
        totalResources: data['totalResources'] as int,
      );
      return right(dashboardStats);
    } catch (e) {
      return left(AppFailure.serverError(e.toString()));
    }
  }
}
