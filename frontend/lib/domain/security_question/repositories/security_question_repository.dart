import '../../../domain/security_question/entities/security_question_entity.dart';


abstract class SecurityQuestionRepository {
  Future<void> submitSecurityAnswers(SecurityAnswers answers);
}
