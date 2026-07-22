import 'package:dartz/dartz.dart';
import '../../core/failures/app_failure.dart';
import '../entities/admin_stats.dart';

abstract class AdminHomeRepository {
  Future<Either<AppFailure, DashboardStats>> fetchDashboardStats();
}
