// import 'lib/infrastructure/category/datasources/category_remote_data_source.dart'
import '../../../domain/category/entities/category.dart';

abstract class CategoryRemoteDataSource {
  Future<List<Category>> getCategories();
}

class CategoryRemoteDataSourceImpl implements CategoryRemoteDataSource {
  @override
  Future<List<Category>> getCategories() async {
    await Future.delayed(const Duration(seconds: 1));

    return [
      Category(id: '1', name: 'ጀማሪ', imageUrl: 'assets/images/beginner.png', quizCount: 3),
      Category(id: '2', name: 'መካከለኛ', imageUrl: 'assets/images/intermediate.png', quizCount: 3),
      Category(id: '3', name: 'አዋቂ', imageUrl: 'assets/images/advanced.png', quizCount: 3),
    ];
  }
}
