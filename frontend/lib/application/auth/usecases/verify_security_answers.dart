import '../../../domain/auth/repositories/auth_repository.dart';

class VerifySecurityAnswersUseCase {
  final AuthRepository repository;

  VerifySecurityAnswersUseCase(this.repository);

  Future<String> call({
    required String username,
    required Map<String, String> providedAnswers,
  }) async {
    return await repository.verifySecurityAnswers(
      username: username,
      providedAnswers: providedAnswers,
    );
  }
}