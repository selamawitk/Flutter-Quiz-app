import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/admin_home/entities/admin_stats.dart';

void main() {
  test('DashboardStats entity should hold correct values', () {
    final stats = DashboardStats(totalUsers: 10, totalQuizzes: 5, totalResources: 3);
    expect(stats.totalUsers, 10);
    expect(stats.totalQuizzes, 5);
    expect(stats.totalResources, 3);
  });
}

