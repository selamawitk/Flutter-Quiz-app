import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/category/entities/category.dart';
import 'package:frontend/infrastructure/category/datasources/category_remote_data_source.dart';
import 'package:frontend/infrastructure/category/repositories_impl/category_repository_impl.dart';

// Mock class using mocktail
class MockCategoryRemoteDataSource extends Mock implements CategoryRemoteDataSource {}

void main() {
  late CategoryRepositoryImpl repository;
  late MockCategoryRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockCategoryRemoteDataSource();
    repository = CategoryRepositoryImpl(mockDataSource);
  });

  test('should return list of categories from remote data source', () async {
    final mockCategories = [
      Category(id: '1', name: 'Mocked Category', imageUrl: 'mock_image.png', quizCount: 5)
    ];

    // Arrange: mock the getCategories() call (not fetchCategories)
    when(() => mockDataSource.getCategories()).thenAnswer((_) async => mockCategories);

    // Act: call the repository method
    final result = await repository.fetchCategories();

    // Assert: verify results and interactions
    expect(result, equals(mockCategories));
    verify(() => mockDataSource.getCategories()).called(1);
  });
}
