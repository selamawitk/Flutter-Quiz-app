import '../entities/security_questions.dart';
abstract class AuthRepository {
  Future<void> login({
    required String username,
    required String password,
    required String role,
  });

  Future<void> saveSecurityQuestions({
    required String username,
    required SecurityQuestions questions,
  });

  Future<Map<String, String>> getSecurityQuestions(String username);

  Future<String> verifySecurityAnswers({
    required String username,
    required Map<String, String> providedAnswers,
  });
  
  Future<bool> resetPassword({
    required String username,
    required String newPassword,
    required String resetToken,
  });
}

abstract class UserRepository {
  Future<bool> doesUserExist(String username);
}
