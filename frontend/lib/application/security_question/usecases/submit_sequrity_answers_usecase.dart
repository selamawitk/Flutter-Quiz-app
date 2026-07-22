import '../../../domain/security_question/entities/security_question_entity.dart';
import '../../../domain/security_question/repositories/security_question_repository.dart';

class SubmitSecurityAnswers {
  final SecurityQuestionRepository repository;

  SubmitSecurityAnswers(this.repository);

  Future<void> call(SecurityAnswers answers) {
    return repository.submitSecurityAnswers(answers);
  }
}
