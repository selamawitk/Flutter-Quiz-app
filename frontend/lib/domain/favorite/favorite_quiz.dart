class FavoriteQuiz {
  final String id;
  final String title;
  final String description;

  FavoriteQuiz({
    required this.id,
    required this.title,
    required this.description,
  });
  factory FavoriteQuiz.empty() {
    return FavoriteQuiz(
      id: '',
      title: '',
      description: '',
    );
  }
}
