import '../../../domain/select_difficulty/entities/difficulty.dart';
import '../../../domain/select_difficulty/repositories/select_difficulty_repository.dart';
import '../datasources/select_difficulty_remote_data_source.dart';

class SelectDifficultyRepositoryImpl implements SelectDifficultyRepository {
  final SelectDifficultyRemoteDataSource dataSource;

  SelectDifficultyRepositoryImpl(this.dataSource);

  @override
  Future<List<Difficulty>> fetchDifficulties() async {
    final labels = await dataSource.getDifficultiesFromServer();
    return labels.map((label) => Difficulty(label: label)).toList();
  }
}
