import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/select_difficulty/usecases/select_difficulty_usecase.dart';
import 'package:frontend/domain/select_difficulty/entities/difficulty.dart';
import 'package:frontend/domain/select_difficulty/repositories/select_difficulty_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockSelectDifficultyRepository extends Mock implements SelectDifficultyRepository {}

void main() {
  group('SelectDifficultyUseCase', () {
    late SelectDifficultyUseCase usecase;
    late MockSelectDifficultyRepository mockRepository;

    setUp(() {
      mockRepository = MockSelectDifficultyRepository();
      usecase = SelectDifficultyUseCase(mockRepository);
    });

    test('should return list of 3 difficulty levels from the repository', () async {
      final mockDifficulties = [
        Difficulty(label: 'Easy'),
        Difficulty(label: 'Medium'),
        Difficulty(label: 'Hard'),
      ];

      when(() => mockRepository.fetchDifficulties()).thenAnswer((_) async => mockDifficulties);

      final result = await usecase();

      expect(result.length, 3);
      expect(result[0].label, 'Easy');
      expect(result[1].label, 'Medium');
      expect(result[2].label, 'Hard');
      verify(() => mockRepository.fetchDifficulties()).called(1);
    });

    test('should handle repository error gracefully', () async {
      when(() => mockRepository.fetchDifficulties()).thenThrow(Exception('Failed to fetch'));

      expect(() => usecase(), throwsA(isA<Exception>()));
      verify(() => mockRepository.fetchDifficulties()).called(1);
    });
  });
}


