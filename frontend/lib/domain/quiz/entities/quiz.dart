class Quiz {
  final String id;
  final String question;
  final List<String> options;
  final String correctAnswer;

  Quiz({
    required this.id,
    required this.question,
    required this.options,
    required this.correctAnswer,
  });
}
