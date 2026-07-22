import '../../domain/quiz/repositories/quiz_repository.dart';
import '../../domain/quiz/entities/question.dart';
import '../../domain/quiz/entities/quiz_session.dart';
import '../../domain/quiz_list/entities/quiz.dart';
import 'quiz_service.dart';

class QuizRepositoryImpl implements QuizRepository {
  final QuizService _quizService = QuizService();
  
  @override
  Future<List<Quiz>> fetchQuizzes() async {
    // Get all quizzes from the service
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
    
    // Parse questions from quiz data
    final questionsData = quizData['questions'] as List<dynamic>;
    return questionsData.map((q) {
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
  }
  
  @override
  Future<QuizSession> startQuizSession(String quizId, String quizTitle, List<Question> questions) async {
    // Create a new session locally
    return QuizSession(
      quizId: quizId,
      quizTitle: quizTitle,
      questions: questions,
      startTime: DateTime.now(),
    );
  }
  
  @override
  Future<QuizSession> answerQuestion(QuizSession session, String questionId, String selectedOptionId) async {
    // Find the question and check if the answer is correct
    final question = session.questions.firstWhere((q) => q.id == questionId);
    final selectedOption = question.options.firstWhere((o) => o.id == selectedOptionId);
    
    // Create new answer
    final answer = Answer(
      questionId: questionId,
      selectedOptionId: selectedOptionId,
      isCorrect: selectedOption.isCorrect,
    );
    
    // Add answer to the list
    final answers = [...session.answers, answer];
    
    // Move to next question if available
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
    // Submit quiz results to backend
    await _quizService.submitQuizAttempt(
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
    
    return session.copyWith(
      isCompleted: true,
      endTime: DateTime.now(),
    );
  }
  
  @override
  Future<List<QuizSession>> getUserQuizHistory() async {
    final historyData = await _quizService.getUserQuizHistory();
    
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
  }
}
