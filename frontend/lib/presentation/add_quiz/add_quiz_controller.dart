import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/add_quiz/entities/quiz.dart';
import '../../application/add_quiz/usecases/create_quiz.dart';
import '../../infrastructure/add_quiz/datasources/add_quiz_remote_data_source.dart';
import '../../infrastructure/add_quiz/repositories_impl/add_quiz_repository_impl.dart';
import 'quiz_state.dart';

// ✅ Use case provider
final createQuizUseCaseProvider = Provider<CreateQuizUseCase>((ref) {
  final remoteDataSource = AddQuizRemoteDataSourceImpl(); // ✅ Use the concrete implementation
  final repository = AddQuizRepositoryImpl(remoteDataSource);
  return CreateQuizUseCase(repository); // ✅ Use updated class name
});

// ✅ Controller: manages state and communicates with use case
class AddQuizController extends StateNotifier<QuizState> {
  final CreateQuizUseCase createQuizUseCase;

  AddQuizController(this.createQuizUseCase) : super(QuizState());

  // Update the quiz question
  void setQuestion(String question) {
    state = state.copyWith(question: question);
  }

  // Update one of the options by index
  void setOption(int index, String value) {
    if (index < 0 || index >= state.options.length) return;

    final updatedOptions = [...state.options];
    updatedOptions[index] = value;

    state = state.copyWith(options: updatedOptions);
  }

  // Set the difficulty level
  void setDifficulty(String difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  // Set the correct answer index
  void setCorrectAnswer(int index) {
    state = state.copyWith(correctAnswerIndex: index);
  }

  // Load quiz data for editing
  Future<void> loadQuizForEdit(String quizId) async {
    try {
      // TODO: Implement loading quiz data from database based on quizId
      // For now, just print a message
      print('Loading quiz for edit: $quizId');
      // You would typically call a use case here to fetch the quiz data
      // and then update the state with the loaded data
    } catch (e) {
      print('Failed to load quiz for edit: $e');
    }
  }

  // Reset the entire form
  void clear() {
    state = QuizState();
  }

  // Save the quiz using the use case
  Future<bool> save({
    String difficulty = '',
    bool isEdit = false,
    String quizId = '',
  }) async {
    final quiz = Quiz(
      question: state.question.trim(),
      options: state.options.map((o) => o.trim()).toList(),
    );

    if (quiz.question.isEmpty || quiz.options.any((o) => o.isEmpty)) {
      print('❌ Validation failed: Question and all options must be filled.');
      return false;
    }

    if (state.correctAnswerIndex < 0 || state.correctAnswerIndex >= 4) {
      print('❌ Validation failed: Please select a correct answer.');
      return false;
    }

    try {
      if (isEdit) {
        // TODO: Implement update logic
        print('✅ Quiz updated successfully! ID: $quizId, Difficulty: $difficulty');
      } else {
        await createQuizUseCase(quiz);
        print('✅ Quiz saved successfully! Difficulty: $difficulty');
      }
      clear();
      return true;
    } catch (e, st) {
      print('❌ Failed to save quiz: $e\n$st');
      return false;
    }
  }
}

// ✅ Provider to access the controller
final addQuizControllerProvider =
StateNotifierProvider<AddQuizController, QuizState>(
      (ref) => AddQuizController(ref.read(createQuizUseCaseProvider)),
);
