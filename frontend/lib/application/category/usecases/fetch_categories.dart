// lib/application/category/usecases/fetch_categories.dart
import '../../../domain/category/entities/category.dart';
import '../../../domain/category/repositories/category_repository.dart';

class FetchCategories {
  final CategoryRepository repository;

  FetchCategories(this.repository);

  Future<List<Category>> call() async {
    return await repository.fetchCategories();
  }
}
