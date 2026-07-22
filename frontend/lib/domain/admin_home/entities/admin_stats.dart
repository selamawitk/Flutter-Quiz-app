import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  final int totalUsers;
  final int totalQuizzes;
  final int totalResources;

  const DashboardStats({
    required this.totalUsers,
    required this.totalQuizzes,
    required this.totalResources,
  });

  @override
  List<Object> get props => [totalUsers, totalQuizzes, totalResources];
}
