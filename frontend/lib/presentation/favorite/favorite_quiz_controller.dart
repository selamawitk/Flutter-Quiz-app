import 'package:frontend/domain/quiz/usecases/view_quiz_use_case.dart';
import 'package:frontend/domain/quiz/usecases/continue_quiz_use_case.dart';
import 'package:frontend/domain/quiz_list/entities/quiz.dart';
// import '../../domain/quiz/entities/quiz.dart';
class FavoriteQuizController {
  final ViewQuizUseCase _viewQuizUseCase;
  final ContinueQuizUseCase _continueQuizUseCase;

  FavoriteQuizController({
    required ViewQuizUseCase viewQuizUseCase,
    required ContinueQuizUseCase continueQuizUseCase,
  })  : _viewQuizUseCase = viewQuizUseCase,
        _continueQuizUseCase = continueQuizUseCase;

  Future<Quiz> viewQuiz(String quizId) async {
    if (quizId.isEmpty) {
      throw ArgumentError('Quiz ID is empty');
    }

    // Execute the use case and return the quiz
    return await _viewQuizUseCase.execute(quizId);
  }

  Future<Quiz> continueQuiz(String quizId) async {
    if (quizId.isEmpty) {
      throw ArgumentError('Quiz ID is empty');
    }

    // Execute the use case and return the quiz
    return await _continueQuizUseCase.execute(quizId);
  }
}
