class SelectDifficultyRemoteDataSource {
  Future<List<String>> getDifficultiesFromServer() async {
    // Simulate API or local response
    await Future.delayed(const Duration(milliseconds: 500));
    return ['Easy', 'Medium', 'Hard', 'Very Hard', 'Insane'];
  }
}
