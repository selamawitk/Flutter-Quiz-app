import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/security_question/datasources/security_question_remote_data_source.dart';
import 'package:frontend/domain/security_question/entities/security_question_entity.dart';

void main() {
  late SecurityQuestionRemoteDataSource dataSource;

  setUp(() {
    dataSource = SecurityQuestionRemoteDataSource();
  });

  test('submitAnswersToApi completes without error', () async {
    final testAnswers = SecurityAnswers(
      question1: 'Question 1 text',
      answer1: 'Answer 1',
      question2: 'Question 2 text',
      answer2: 'Answer 2',
    );

    // Use the defined variable testAnswers here
    await expectLater(dataSource.submitAnswersToApi(testAnswers), completes);
  });
}
