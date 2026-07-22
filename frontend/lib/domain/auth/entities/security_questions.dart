import 'user_entity.dart';

class SecurityQuestions {
  final UserEntity user;
  final String question1;
  final String answer1;
  final String question2;
  final String answer2;

  SecurityQuestions({
    required this.user,
    required this.question1,
    required this.answer1,
    required this.question2,
    required this.answer2,
  });
}
