import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/infrastructure/choice/datasources/choice_remote_data_source.dart';
import 'package:frontend/infrastructure/choice/repositories_impl/choice_repository_impl.dart';

// Mock ChoiceRemoteDataSource
class MockChoiceRemoteDataSource extends Mock implements ChoiceRemoteDataSource {}

void main() {
  late MockChoiceRemoteDataSource mockRemoteDataSource;
  late ChoiceRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockChoiceRemoteDataSource();
    repository = ChoiceRepositoryImpl(mockRemoteDataSource);
  });

  group('ChoiceRepositoryImpl', () {
    test('goToQuiz calls remoteDataSource.navigateToQuiz', () async {
      when(() => mockRemoteDataSource.navigateToQuiz()).thenAnswer((_) async {});

      await repository.goToQuiz();

      verify(() => mockRemoteDataSource.navigateToQuiz()).called(1);
    });

    test('goToResources calls remoteDataSource.navigateToResources', () async {
      when(() => mockRemoteDataSource.navigateToResources()).thenAnswer((_) async {});

      await repository.goToResources();

      verify(() => mockRemoteDataSource.navigateToResources()).called(1);
    });
  });
}
