import '../../../domain/security_question/entities/security_question_entity.dart';
import '../../../domain/security_question/repositories/security_question_repository.dart';
import '../datasources/security_question_remote_data_source.dart';

class SecurityQuestionRepositoryImpl implements SecurityQuestionRepository {
  final SecurityQuestionRemoteDataSource dataSource;

  SecurityQuestionRepositoryImpl(this.dataSource);

  @override
  Future<void> submitSecurityAnswers(SecurityAnswers answers) {
    return dataSource.submitAnswersToApi(answers);
  }
}
