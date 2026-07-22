import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'quiz_service.dart';

// Provider for QuizService
final quizServiceProvider = Provider<QuizService>((ref) {
  return QuizService();
});

// Provider for quiz list
final quizzesProvider = FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final quizService = ref.read(quizServiceProvider);
  return await quizService.getAllQuizzes();
});

// Provider for quiz categories
final quizCategoriesProvider = FutureProvider<List<String>>((ref) async {
  final quizService = ref.read(quizServiceProvider);
  return await quizService.getQuizCategories();
});

// Provider for a specific quiz by ID
final quizByIdProvider = FutureProviderFamily<Map<String, dynamic>, String>((ref, id) async {
  final quizService = ref.read(quizServiceProvider);
  return await quizService.getQuizById(id);
});

// Provider to handle quiz operations
final quizControllerProvider = Provider((ref) => QuizController(ref));

class QuizController {
  final Ref _ref;

  QuizController(this._ref);

  // Create new quiz
  Future<Map<String, dynamic>?> createQuiz(Map<String, dynamic> quizData) async {
    try {
      final quizService = _ref.read(quizServiceProvider);
      final result = await quizService.createQuiz(quizData);
      
      // Refresh quiz list
      _ref.refresh(quizzesProvider);
      
      return result;
    } catch (e) {
      return null;
    }
  }

  // Update quiz
  Future<Map<String, dynamic>?> updateQuiz(String id, Map<String, dynamic> quizData) async {
    try {
      final quizService = _ref.read(quizServiceProvider);
      final result = await quizService.updateQuiz(id, quizData);
      
      // Refresh quiz list and specific quiz
      _ref.refresh(quizzesProvider);
      _ref.refresh(quizByIdProvider(id));
      
      return result;
    } catch (e) {
      return null;
    }
  }

  // Delete quiz
  Future<bool> deleteQuiz(String id) async {
    try {
      final quizService = _ref.read(quizServiceProvider);
      final result = await quizService.deleteQuiz(id);
      
      // Refresh quiz list
      _ref.refresh(quizzesProvider);
      
      return result;
    } catch (e) {
      return false;
    }
  }
} 