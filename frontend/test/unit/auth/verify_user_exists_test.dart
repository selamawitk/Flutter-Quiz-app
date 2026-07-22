import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/auth/usecases/verify_user_exists.dart';
import 'package:frontend/domain/auth/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  group('CheckUsernameExistsUseCase', () {
    late MockUserRepository mockRepository;
    late CheckUsernameExistsUseCase useCase;

    setUp(() {
      mockRepository = MockUserRepository();
      useCase = CheckUsernameExistsUseCase(mockRepository);
    });

    test('returns true when username exists', () async {
      when(() => mockRepository.doesUserExist(any()))
          .thenAnswer((_) async => true);

      final exists = await useCase.call('existing_user');

      expect(exists, isTrue);
      verify(() => mockRepository.doesUserExist('existing_user')).called(1);
    });
  });
}
