import '../../../domain/auth/entities/security_questions.dart';
import '../../../domain/auth/repositories/auth_repository.dart';

class SaveSecurityQuestionsUseCase {
  final AuthRepository repository;

  SaveSecurityQuestionsUseCase(this.repository);

  Future<void> execute({
    required String username,
    required SecurityQuestions questions,
  }) {
    return repository.saveSecurityQuestions(
      username: username,
      questions: questions,
    );
  }
}
