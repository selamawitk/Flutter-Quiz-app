
import '../../../domain/choice/repositories/choice_repository.dart';
import '../datasources/choice_remote_data_source.dart';

class ChoiceRepositoryImpl implements ChoiceRepository {
  final ChoiceRemoteDataSource remoteDataSource;

  // Inject the remoteDataSource directly
  ChoiceRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> goToQuiz() async {
    await remoteDataSource.navigateToQuiz();
  }

  @override
  Future<void> goToResources() async {
    await remoteDataSource.navigateToResources();
  }
}
