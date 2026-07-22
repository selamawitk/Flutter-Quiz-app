import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'category_service.dart';

// Provider for CategoryService
final categoryServiceProvider = Provider<CategoryService>((ref) {
  return CategoryService();
});

// Provider for categories list (returns category names as strings)
final categoryNamesProvider = FutureProvider<List<String>>((ref) async {
  final categoryService = ref.read(categoryServiceProvider);
  return await categoryService.getAllCategories();
});

// Provider for quizzes by category
final quizzesByCategoryProvider = FutureProviderFamily<List<Map<String, dynamic>>, String>((ref, category) async {
  final categoryService = ref.read(categoryServiceProvider);
  return await categoryService.getQuizzesByCategory(category);
});

// Provider to handle category operations
final categoryControllerProvider = Provider((ref) => CategoryController(ref));

class CategoryController {
  final Ref _ref;

  CategoryController(this._ref);

  Future<List<String>> getCategories() async {
    final categoriesAsync = await _ref.read(categoryNamesProvider.future);
    return categoriesAsync;
  }

  Future<List<Map<String, dynamic>>> getQuizzesByCategory(String category) async {
    final quizzesAsync = await _ref.read(quizzesByCategoryProvider(category).future);
    return quizzesAsync;
  }
}
