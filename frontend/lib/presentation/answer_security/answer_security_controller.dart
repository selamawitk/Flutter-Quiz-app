import '../../application/auth/usecases/verify_security_answers.dart';
import '../../domain/auth/repositories/auth_repository.dart';

class SecurityQuestionsController {
  final VerifySecurityAnswersUseCase verifyAnswersUseCase;
  final AuthRepository authRepository;

  SecurityQuestionsController(this.verifyAnswersUseCase, this.authRepository);

  Future<Map<String, String>> getQuestionsForUser(String username) async {
    return await authRepository.getSecurityQuestions(username);
  }

  Future<String> verifyAnswers(String username, Map<String, String> answers) async {
    return await verifyAnswersUseCase(
      username: username,
      providedAnswers: answers,
    );
  }
}
