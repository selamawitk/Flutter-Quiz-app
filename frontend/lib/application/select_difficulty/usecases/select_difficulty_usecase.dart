import '../../../domain/select_difficulty/entities/difficulty.dart';
import '../../../domain/select_difficulty/repositories/select_difficulty_repository.dart';

class SelectDifficultyUseCase {
  final SelectDifficultyRepository repository;

  SelectDifficultyUseCase(this.repository);

  Future<List<Difficulty>> call() async {
    return await repository.fetchDifficulties();
  }
}
