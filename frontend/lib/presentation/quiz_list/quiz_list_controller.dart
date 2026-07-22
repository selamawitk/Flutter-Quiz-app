import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/quiz_list/entities/quiz.dart';
import '../../application/quiz_list/usecases/get_quizzes.dart';
import '../../infrastructure/quiz_list/datasources/quiz_remote_data_source.dart';
import '../../infrastructure/quiz_list/repositories_impl/quiz_repository_impl.dart';

// Provide the repository instance
final quizRepositoryProvider = Provider((ref) {
  // Corrected: Instantiate QuizRemoteDataSourceImpl
  return QuizRepositoryImpl(QuizRemoteDataSourceImpl());
});

// Provide the usecase instance
final getQuizzesProvider = Provider((ref) {
  final repo = ref.read(quizRepositoryProvider);
  return GetQuizzes(repo);
});

// StateNotifier to hold List<Quiz>
final quizListProvider =
StateNotifierProvider<QuizListController, List<Quiz>>((ref) {
  final getQuizzes = ref.read(getQuizzesProvider);
  return QuizListController(getQuizzes, ref);
});

class QuizListController extends StateNotifier<List<Quiz>> {
  final GetQuizzes getQuizzes;
  final Ref ref;

  QuizListController(this.getQuizzes, this.ref) : super([]) {
    loadQuizzes();
  }

  Future<void> loadQuizzes() async {
    final quizzes = await getQuizzes();
    state = quizzes;
  }

  Future<void> removeQuiz(String id) async {
    await ref.read(quizRepositoryProvider).removeQuiz(id);
    state = state.where((quiz) => quiz.id != id).toList();
  }
}
