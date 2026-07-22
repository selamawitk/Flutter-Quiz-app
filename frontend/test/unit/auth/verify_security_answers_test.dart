import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/auth/usecases/verify_security_answers.dart';
import 'package:frontend/domain/auth/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('VerifySecurityAnswersUseCase', () {
    late MockAuthRepository mockRepository;
    late VerifySecurityAnswersUseCase useCase;

    setUp(() {
      mockRepository = MockAuthRepository();
      useCase = VerifySecurityAnswersUseCase(mockRepository);
    });

    test('returns resetToken when repository verifies answers successfully', () async {
      when(() => mockRepository.verifySecurityAnswers(
        username: any(named: 'username'),
        providedAnswers: any(named: 'providedAnswers'),
      )).thenAnswer((_) async => 'reset-token-123');

      final result = await useCase.call(
        username: 'testuser',
        providedAnswers: {
          'question1': 'Fluffy',
          'question2': 'Blue',
        },
      );

      expect(result, equals('reset-token-123'));
    });
  });
}
