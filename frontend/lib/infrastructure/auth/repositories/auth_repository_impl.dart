import '../../../domain/auth/repositories/auth_repository.dart';
import '../../../domain/auth/entities/security_questions.dart';
import '../auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService _authService = AuthService();

  @override
  Future<void> login({
    required String username,
    required String password,
    required String role,
  }) async {
    await _authService.login(username, password, role);
  }
  
  @override
  Future<void> saveSecurityQuestions({
    required String username,
    required SecurityQuestions questions,
  }) async {
    await _authService.setSecurityQuestions(username, {
      'question1': {
        'question': questions.question1,
        'answer': questions.answer1,
      },
      'question2': {
        'question': questions.question2,
        'answer': questions.answer2,
      },
    });
  }

  @override
  Future<Map<String, String>> getSecurityQuestions(String username) async {
    return await _authService.getSecurityQuestions(username);
  }

  @override
  Future<String> verifySecurityAnswers({
    required String username,
    required Map<String, String> providedAnswers,
  }) async {
    return await _authService.verifySecurityAnswers(username, providedAnswers);
  }
  
  @override
  Future<bool> resetPassword({
    required String username,
    required String newPassword,
    required String resetToken,
  }) async {
    return await _authService.resetPassword(username, newPassword, resetToken);
  }
}

class UserRepositoryImpl implements UserRepository {
  final AuthService _authService = AuthService();

  @override
  Future<bool> doesUserExist(String username) async {
    try {
      return await _authService.checkUsernameExists(username);
    } catch (e) {
      return false;
    }
  }
}
