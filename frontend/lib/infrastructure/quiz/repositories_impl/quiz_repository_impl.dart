import '../../../domain/quiz_list/entities/quiz.dart';
import '../../../domain/quiz/repositories/quiz_repository.dart';
import '../../../domain/quiz/entities/question.dart';
import '../../../domain/quiz/entities/quiz_session.dart';
import '../quiz_service.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizService _quizService = QuizService();

  @override
  Future<List<Quiz>> fetchQuizzes() async {
    final quizzesData = await _quizService.getAllQuizzes();
    return quizzesData.map((data) => Quiz(
      id: data['_id'] ?? '',
      title: data['title'] ?? '',
    )).toList();
  }

  @override
  Future<Map<String, dynamic>> getQuizById(String id) async {
    return await _quizService.getQuizById(id);
  }

  @override
  Future<List<Question>> getQuizQuestions(String quizId) async {
    final quizData = await _quizService.getQuizById(quizId);
    final questionsData = quizData['questions'] as List<dynamic>;
    return questionsData.map((q) {
      final options = (q['options'] as List<dynamic>).map((opt) =>
        Option(
          id: opt['_id'] ?? '',
          text: opt.toString(),
          isCorrect: opt.toString() == q['correctAnswer'],
        )
      ).toList();
      return Question(
        id: q['_id'] ?? '',
        text: q['questionText'] ?? '',
        options: options,
      );
    }).toList();
  }

  @override
  Future<QuizSession> startQuizSession(String quizId, String quizTitle, List<Question> questions) async {
    return QuizSession(
      quizId: quizId,
      quizTitle: quizTitle,
      questions: questions,
      startTime: DateTime.now(),
    );
  }

  @override
  Future<QuizSession> answerQuestion(QuizSession session, String questionId, String selectedOptionId) async {
    final question = session.questions.firstWhere((q) => q.id == questionId);
    final selectedOption = question.options.firstWhere((o) => o.id == selectedOptionId);
    final answer = Answer(
      questionId: questionId,
      selectedOptionId: selectedOptionId,
      isCorrect: selectedOption.isCorrect,
    );
    final answers = [...session.answers, answer];
    final nextQuestionIndex = session.currentQuestionIndex + 1;
    final isCompleted = nextQuestionIndex >= session.questions.length;
    return session.copyWith(
      answers: answers,
      currentQuestionIndex: nextQuestionIndex,
      isCompleted: isCompleted,
      endTime: isCompleted ? DateTime.now() : null,
    );
  }

  @override
  Future<QuizSession> completeQuizSession(QuizSession session) async {
    return session.copyWith(isCompleted: true, endTime: DateTime.now());
  }

  @override
  Future<List<QuizSession>> getUserQuizHistory() async {
    return [];
  }
}
