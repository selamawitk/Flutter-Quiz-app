import 'package:frontend/domain/add_quiz/entities/quiz.dart';
import 'package:frontend/domain/add_quiz/repositories/add_quiz_repository.dart';

class CreateQuiz {
  final AddQuizRepository repository;

  CreateQuiz(this.repository);

  Future<void> call(Quiz quiz) {
    return repository.createQuiz(quiz);
  }
}

