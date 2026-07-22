import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/auth/usecases/save_security_questions.dart';
import 'package:frontend/domain/auth/entities/security_questions.dart';
import 'package:frontend/domain/auth/entities/user_entity.dart';
import 'package:frontend/domain/auth/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('SaveSecurityQuestionsUseCase', () {
    late MockAuthRepository mockRepository;
    late SaveSecurityQuestionsUseCase useCase;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = SaveSecurityQuestionsUseCase(mockRepository);
    });

    test('calls repository.saveSecurityQuestions with correct arguments', () async {
      final user = UserEntity(username: 'testuser');
      final questions = SecurityQuestions(
        user: user,
        question1: 'What\'s your pet\'s name?',
        answer1: 'Fluffy',
        question2: 'Favorite color?',
        answer2: 'Blue',
      );

      when(() => mockRepository.saveSecurityQuestions(
        username: any(named: 'username'),
        questions: any(named: 'questions'),
      )).thenAnswer((_) async => Future.value());

      await useCase.execute(
        username: 'testuser',
        questions: questions,
      );

      verify(() => mockRepository.saveSecurityQuestions(
        username: 'testuser',
        questions: questions,
      )).called(1);
    });
  });
}
