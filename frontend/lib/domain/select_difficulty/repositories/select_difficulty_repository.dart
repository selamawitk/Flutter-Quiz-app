import '../entities/difficulty.dart';
abstract class SelectDifficultyRepository {
  Future<List<Difficulty>> fetchDifficulties();
}
