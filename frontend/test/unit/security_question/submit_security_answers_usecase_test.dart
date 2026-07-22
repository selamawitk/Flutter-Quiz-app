import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/security_question/usecases/submit_sequrity_answers_usecase.dart';
import 'package:frontend/domain/security_question/entities/security_question_entity.dart';
import 'package:frontend/domain/security_question/repositories/security_question_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockSecurityQuestionRepository extends Mock implements SecurityQuestionRepository {}

void main() {
  late SubmitSecurityAnswers useCase;
  late MockSecurityQuestionRepository mockRepository;

  setUp(() {
    mockRepository = MockSecurityQuestionRepository();
    useCase = SubmitSecurityAnswers(mockRepository);
  });

  test('should call repository.submitSecurityAnswers with correct answers', () async {
    final answers = SecurityAnswers(
      question1: 'What is your pet\'s name?',
      answer1: 'Fluffy',
      question2: 'What is your mother\'s maiden name?',
      answer2: 'Smith',
    );

    when(() => mockRepository.submitSecurityAnswers(answers))
        .thenAnswer((_) async => Future.value());

    await useCase.call(answers);

    verify(() => mockRepository.submitSecurityAnswers(answers)).called(1);
  });
}
