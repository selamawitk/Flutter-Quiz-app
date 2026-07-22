import 'package:dartz/dartz.dart';
import '../../../domain/answer_security/entities/answer_security.dart';
import '../../../domain/answer_security/repositories/answer_security_repository.dart';

class VerifySecurityAnswer {
  final AnswerSecurityRepository repository;

  VerifySecurityAnswer(this.repository);

  Future<Either<String, AnswerSecurity>> call(String username, String answer) async {
    // Validate inputs
    if (username.trim().isEmpty) {
      return const Left('Username cannot be empty');
    }

    if (answer.trim().isEmpty) {
      return const Left('Security answer cannot be empty');
    }

    // Get security question first to ensure user exists
    final questionResult = await repository.getSecurityQuestion(username);
    if (questionResult.isLeft()) {
      return questionResult.fold(
        (error) => Left('Failed to retrieve security question: $error'),
        (question) => const Left('Failed to retrieve security question'),
      );
    }

    // Verify the answer
    return await repository.verifySecurityAnswer(username, answer.trim());
  }
} 