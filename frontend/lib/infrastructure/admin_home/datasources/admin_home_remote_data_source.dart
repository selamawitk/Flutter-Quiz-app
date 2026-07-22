abstract class AdminHomeRemoteDataSource {
  Future<Map<String, dynamic>> fetchStats();
}

class AdminHomeRemoteDataSourceImpl implements AdminHomeRemoteDataSource {
  AdminHomeRemoteDataSourceImpl();

  @override
  Future<Map<String, dynamic>> fetchStats() async {
    // Backend does not have a dedicated stats endpoint yet.
    // Return default stats that the UI can display.
    return {
      'totalUsers': 0,
      'totalQuizzes': 0,
      'totalResources': 0,
    };
  }
}
