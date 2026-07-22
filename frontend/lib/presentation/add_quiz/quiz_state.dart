class QuizState {
  final String question;
  final List<String> options;
  final String difficulty;
  final int correctAnswerIndex;

  QuizState({
    this.question = '',
    List<String>? options,
    this.difficulty = '',
    this.correctAnswerIndex = -1,
  }) : options = options ?? ['', '', '', ''];

  QuizState copyWith({
    String? question,
    List<String>? options,
    String? difficulty,
    int? correctAnswerIndex,
  }) {
    return QuizState(
      question: question ?? this.question,
      options: options ?? this.options,
      difficulty: difficulty ?? this.difficulty,
      correctAnswerIndex: correctAnswerIndex ?? this.correctAnswerIndex,
    );
  }
}
