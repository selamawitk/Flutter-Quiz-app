import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/quiz/entities/question.dart';
import '../../domain/quiz/entities/quiz_session.dart';
import 'quiz_service.dart';

// Provider for QuizService
final quizServiceProvider = Provider<QuizService>((ref) {
  return QuizService();
});

// Provider for active quiz session
final quizSessionProvider = StateNotifierProvider<QuizSessionNotifier, QuizSession?>((ref) {
  return QuizSessionNotifier();
});

// Provider for a specific quiz by ID
final quizByIdProvider = FutureProviderFamily<Map<String, dynamic>, String>((ref, id) async {
  final quizService = ref.read(quizServiceProvider);
  return await quizService.getQuizById(id);
});

// Provider for user's quiz history
final quizHistoryProvider = FutureProvider<List<QuizSession>>((ref) async {
  final quizService = ref.read(quizServiceProvider);
  final historyData = await quizService.getUserQuizHistory();
  
  return historyData.map((data) {
    final questions = (data['questions'] as List<dynamic>).map((q) {
      final options = (q['options'] as List<dynamic>).map((opt) => 
        Option(
          id: opt['_id'] ?? '',
          text: opt['text'] ?? '',
          isCorrect: opt['isCorrect'] ?? false,
        )
      ).toList();
      
      return Question(
        id: q['_id'] ?? '',
        text: q['text'] ?? '',
        options: options,
        points: q['points'] ?? 1,
      );
    }).toList();
    
    final answers = (data['answers'] as List<dynamic>).map((a) => 
      Answer(
        questionId: a['questionId'] ?? '',
        selectedOptionId: a['selectedOptionId'] ?? '',
        isCorrect: a['isCorrect'] ?? false,
      )
    ).toList();
    
    return QuizSession(
      quizId: data['quizId'] ?? '',
      quizTitle: data['quizTitle'] ?? '',
      questions: questions,
      answers: answers,
      currentQuestionIndex: questions.length,
      isCompleted: true,
      startTime: DateTime.parse(data['startTime'] ?? DateTime.now().toIso8601String()),
      endTime: data['endTime'] != null ? DateTime.parse(data['endTime']) : null,
    );
  }).toList();
});

// Quiz Session State Notifier
class QuizSessionNotifier extends StateNotifier<QuizSession?> {
  QuizSessionNotifier() : super(null);
  
  void startQuiz(String quizId, String quizTitle, List<Question> questions) {
    state = QuizSession(
      quizId: quizId,
      quizTitle: quizTitle,
      questions: questions,
      startTime: DateTime.now(),
    );
  }
  
  void answerQuestion(String questionId, String selectedOptionId) {
    if (state == null) return;
    
    // Find the question and check if the answer is correct
    final question = state!.questions.firstWhere((q) => q.id == questionId);
    final selectedOption = question.options.firstWhere((o) => o.id == selectedOptionId);
    
    // Create new answer
    final answer = Answer(
      questionId: questionId,
      selectedOptionId: selectedOptionId,
      isCorrect: selectedOption.isCorrect,
    );
    
    // Add answer to the list
    final answers = [...state!.answers, answer];
    
    // Move to next question if available
    final nextQuestionIndex = state!.currentQuestionIndex + 1;
    final isCompleted = nextQuestionIndex >= state!.questions.length;
    
    state = state!.copyWith(
      answers: answers,
      currentQuestionIndex: nextQuestionIndex,
      isCompleted: isCompleted,
      endTime: isCompleted ? DateTime.now() : null,
    );
  }
  
  void completeQuiz() {
    if (state == null) return;
    
    state = state!.copyWith(
      isCompleted: true,
      endTime: DateTime.now(),
    );
  }
  
  void resetQuiz() {
    state = null;
  }
}

// Provider to handle quiz operations
final quizControllerProvider = Provider((ref) => QuizController(ref));

class QuizController {
  final Ref _ref;

  QuizController(this._ref);

  Future<Map<String, dynamic>> getQuizById(String id) async {
    return await _ref.read(quizByIdProvider(id).future);
  }
  
  void startQuiz(String quizId, String quizTitle, List<Question> questions) {
    _ref.read(quizSessionProvider.notifier).startQuiz(quizId, quizTitle, questions);
  }
  
  void answerQuestion(String questionId, String selectedOptionId) {
    _ref.read(quizSessionProvider.notifier).answerQuestion(questionId, selectedOptionId);
  }
  
  void completeQuiz() {
    final session = _ref.read(quizSessionProvider);
    if (session == null) return;
    
    // Submit quiz results to backend
    _ref.read(quizServiceProvider).submitQuizAttempt(
      session.quizId,
      {
        'quizId': session.quizId,
        'startTime': session.startTime.toIso8601String(),
        'endTime': DateTime.now().toIso8601String(),
        'answers': session.answers.map((a) => {
          'questionId': a.questionId,
          'selectedOptionId': a.selectedOptionId,
          'isCorrect': a.isCorrect,
        }).toList(),
      },
    );
    
    _ref.read(quizSessionProvider.notifier).completeQuiz();
    
    // Refresh quiz history
    _ref.refresh(quizHistoryProvider);
  }
  
  void resetQuiz() {
    _ref.read(quizSessionProvider.notifier).resetQuiz();
  }
  
  Future<List<QuizSession>> getUserQuizHistory() async {
    return await _ref.read(quizHistoryProvider.future);
  }
} 