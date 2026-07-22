import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/application/result/usecases/fetch_results.dart';
import 'package:frontend/domain/result/entities/result.dart';
import 'package:frontend/domain/result/repositories/result_repository.dart';

// Mock class for the repository
class MockResultRepository extends Mock implements ResultRepository {}

void main() {
  late FetchResultUseCase useCase;
  late MockResultRepository mockRepository;

  setUp(() {
    mockRepository = MockResultRepository();
    useCase = FetchResultUseCase(mockRepository);
  });

  final tResults = [
    Result(
      id: 'r1',
      title: 'Final Quiz Result',
      score: 7,
      total: 10,
    ),
  ];

  test('should get list of results from repository', () async {
    // Arrange: mock fetchResults() to return tResults
    when(() => mockRepository.fetchResults()).thenAnswer((_) async => tResults);

    // Act
    final result = await useCase();

    // Assert
    expect(result, tResults);
    verify(() => mockRepository.fetchResults()).called(1);
  });
}
