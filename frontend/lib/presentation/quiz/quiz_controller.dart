class QuizViewModel {
  final String questionText;
  final List<String> options;
  final String correctAnswer;
  String? selectedOption;

  QuizViewModel({
    required this.questionText,
    required this.options,
    required this.correctAnswer,
    this.selectedOption,
  });

  void selectOption(String option) {
    selectedOption = option;
  }

  void moveToNextQuestion() {
    // moving to next question logic
  }
}
