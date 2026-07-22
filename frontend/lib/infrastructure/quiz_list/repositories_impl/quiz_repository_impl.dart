import '../../../domain/quiz_list/entities/quiz.dart';
import '../../../domain/quiz_list/repositories/quiz_repository.dart';
import '../datasources/quiz_remote_data_source.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizRemoteDataSource remoteDataSource;

  // In-memory storage for demo (simulate delete)
  List<Quiz> _cachedQuizzes = [];

  QuizRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<Quiz>> getQuizzes() async {
    if (_cachedQuizzes.isEmpty) {
      _cachedQuizzes = await remoteDataSource.fetchQuizzes();
    }
    return _cachedQuizzes;
  }

  @override
  Future<void> removeQuiz(String id) async {
    _cachedQuizzes.removeWhere((quiz) => quiz.id == id);
  }
}
