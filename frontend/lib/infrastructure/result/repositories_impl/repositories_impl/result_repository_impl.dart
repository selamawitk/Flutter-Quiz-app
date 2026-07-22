import '../../../../domain/result/entities/result.dart';
import '../../../../domain/result/repositories/result_repository.dart';
import '../../datasources/result_remote_data_source.dart';

class ResultRepositoryImpl implements ResultRepository {
  final ResultRemoteDataSource remoteDataSource;

  ResultRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Result>> fetchResults() {
    return remoteDataSource.fetchResults();
  }
}
