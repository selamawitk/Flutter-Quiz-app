import '../../../domain/security_question/entities/security_question_entity.dart';


class SecurityQuestionRemoteDataSource {
  Future<void> submitAnswersToApi(SecurityAnswers answers) async {
    // TODO: Implement actual API call using Dio or HTTP
    await Future.delayed(Duration(seconds: 1));
  }
}
