import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/admin_home/usecases/fetch_dashboard_stats.dart';
import 'package:frontend/domain/admin_home/entities/admin_stats.dart';
import 'package:frontend/domain/admin_home/repositories/admin_home_repository.dart';
import 'package:frontend/domain/core/failures/app_failure.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';

class MockAdminHomeRepository extends Mock implements AdminHomeRepository {}

void main() {
  late FetchDashboardStatsUseCase useCase;
  late MockAdminHomeRepository mockRepository;

  setUp(() {
    mockRepository = MockAdminHomeRepository();
    useCase = FetchDashboardStatsUseCase(mockRepository);
  });

  test('should return DashboardStats from the repository on success', () async {
    final tDashboardStats = DashboardStats(
      totalUsers: 100,
      totalQuizzes: 50,
      totalResources: 25,
    );

    // Mock the repository call to return a successful result (Right)
    when(() => mockRepository.fetchDashboardStats())
        .thenAnswer((_) async => right(tDashboardStats));

    // Call the use case
    final result = await useCase();

    // Assert that the result is the expected DashboardStats wrapped in Right
    expect(result, right(tDashboardStats));
    // Verify that the repository method was called exactly once
    verify(() => mockRepository.fetchDashboardStats()).called(1);
  });

  test('should return AppFailure when the repository call fails', () async {
    final tFailure = ServerFailure('Server is down'); // Use the concrete ServerFailure

    // Mock the repository call to return a failure result (Left)
    when(() => mockRepository.fetchDashboardStats())
        .thenAnswer((_) async => left(tFailure));

    // Call the use case
    final result = await useCase();

    // Assert that the result is the expected AppFailure wrapped in Left
    expect(result, left(tFailure));
    // Verify that the repository method was called exactly once
    verify(() => mockRepository.fetchDashboardStats()).called(1);
  });
}
