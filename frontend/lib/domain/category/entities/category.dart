// lib/domain/category/entities/category.dart
class Category {
  final String id;
  final String name;
  final String imageUrl;
  final int quizCount;

  Category({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.quizCount,
  });
}
