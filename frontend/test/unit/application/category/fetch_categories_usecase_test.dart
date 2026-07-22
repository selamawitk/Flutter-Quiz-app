import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/category/entities/category.dart';
import 'package:frontend/domain/category/repositories/category_repository.dart';
import 'package:frontend/application/category/usecases/fetch_categories.dart';

// Mock class
class MockCategoryRepository extends Mock implements CategoryRepository {}

void main() {
  late FetchCategories useCase;
  late MockCategoryRepository mockRepository;

  setUp(() {
    mockRepository = MockCategoryRepository();
    useCase = FetchCategories(mockRepository);
  });

  test('should return list of categories from repository', () async {
    final mockCategories = [
      Category(id: '1', name: 'Science', imageUrl: 'science.png', quizCount: 10),
    ];
    when(() => mockRepository.fetchCategories())
        .thenAnswer((_) async => mockCategories);

    final result = await useCase.call();

    expect(result, equals(mockCategories));
    verify(() => mockRepository.fetchCategories()).called(1);
  });
}
