import '../../../domain/add_quiz/entities/quiz.dart';
import '../../../domain/add_quiz/repositories/add_quiz_repository.dart';

class CreateQuizUseCase {
  final AddQuizRepository repository;

  CreateQuizUseCase(this.repository);

  Future<void> call(Quiz quiz) async {
    await repository.createQuiz(quiz);
  }
}
