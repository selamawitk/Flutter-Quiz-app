import 'package:equatable/equatable.dart';
import 'question.dart';

class Answer extends Equatable {
  final String questionId;
  final String selectedOptionId;
  final bool isCorrect;

  const Answer({
    required this.questionId,
    required this.selectedOptionId,
    required this.isCorrect,
  });

  @override
  List<Object> get props => [questionId, selectedOptionId, isCorrect];
}

class QuizSession extends Equatable {
  final String quizId;
  final String quizTitle;
  final List<Question> questions;
  final List<Answer> answers;
  final int currentQuestionIndex;
  final bool isCompleted;
  final DateTime startTime;
  final DateTime? endTime;

  const QuizSession({
    required this.quizId,
    required this.quizTitle,
    required this.questions,
    this.answers = const [],
    this.currentQuestionIndex = 0,
    this.isCompleted = false,
    required this.startTime,
    this.endTime,
  });

  int get totalQuestions => questions.length;
  
  int get correctAnswers => answers.where((answer) => answer.isCorrect).length;
  
  double get score {
    if (answers.isEmpty) return 0.0;
    return (correctAnswers / totalQuestions) * 100;
  }

  QuizSession copyWith({
    String? quizId,
    String? quizTitle,
    List<Question>? questions,
    List<Answer>? answers,
    int? currentQuestionIndex,
    bool? isCompleted,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return QuizSession(
      quizId: quizId ?? this.quizId,
      quizTitle: quizTitle ?? this.quizTitle,
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      isCompleted: isCompleted ?? this.isCompleted,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  @override
  List<Object?> get props => [
    quizId,
    quizTitle,
    questions,
    answers,
    currentQuestionIndex,
    isCompleted,
    startTime,
    endTime,
  ];
} 