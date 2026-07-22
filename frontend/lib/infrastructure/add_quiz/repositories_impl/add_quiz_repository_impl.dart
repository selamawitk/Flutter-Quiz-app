import '../../../domain/add_quiz/entities/quiz.dart';
import '../../../domain/add_quiz/repositories/add_quiz_repository.dart';
import '../datasources/add_quiz_remote_data_source.dart';

class AddQuizRepositoryImpl implements AddQuizRepository {
  final AddQuizRemoteDataSource remoteDataSource;

  AddQuizRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createQuiz(Quiz quiz) async {
    return await remoteDataSource.createQuiz(quiz);
  }
}
