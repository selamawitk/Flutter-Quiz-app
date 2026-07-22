import 'package:dartz/dartz.dart';
import '../entities/answer_security.dart';

abstract class AnswerSecurityRepository {
  Future<Either<String, AnswerSecurity>> verifySecurityAnswer(
    String username, 
    String answer
  );
  Future<Either<String, String>> getSecurityQuestion(String username);
  Future<Either<String, bool>> updateSecurityQuestion(
    String username, 
    String question, 
    String answer
  );
} 