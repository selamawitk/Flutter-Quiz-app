import '../../../domain/result/entities/result.dart';
import '../../../domain/result/repositories/result_repository.dart';

class FetchResultUseCase {
  final ResultRepository repository;

  FetchResultUseCase(this.repository);

  Future<Result> call() async {
    final results = await repository.fetchResults();
    if (results.isEmpty) {
      throw Exception('No results found');
    }
    return results.first;
  }
}
