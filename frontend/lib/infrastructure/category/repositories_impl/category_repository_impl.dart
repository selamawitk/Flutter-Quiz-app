// lib/infrastructure/category/repositories_impl/category_repository_impl.dart
import '../../../domain/category/entities/category.dart';
import '../../../domain/category/repositories/category_repository.dart';
import '../datasources/category_remote_data_source.dart';

class CategoryRepositoryImpl implements CategoryRepository {
  final CategoryRemoteDataSource remoteDataSource;

  CategoryRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Category>> fetchCategories() async {
    return await remoteDataSource.getCategories();
  }
}

