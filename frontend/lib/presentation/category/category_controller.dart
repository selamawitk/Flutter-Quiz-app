// lib/presentation/category/category_controller.dart
import 'package:flutter/material.dart';
import '../../domain/category/entities/category.dart';
import '../../application/category/usecases/fetch_categories.dart';
import '../../infrastructure/category/datasources/category_remote_data_source.dart';
import '../../infrastructure/category/repositories_impl/category_repository_impl.dart';

class CategoryController with ChangeNotifier {
  final FetchCategories fetchCategories;

  CategoryController()
      : fetchCategories = FetchCategories(
    CategoryRepositoryImpl(CategoryRemoteDataSourceImpl()),
  );

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> loadCategories() async {
    _isLoading = true;
    notifyListeners();

    _categories = await fetchCategories();

    _isLoading = false;
    notifyListeners();
  }
}
