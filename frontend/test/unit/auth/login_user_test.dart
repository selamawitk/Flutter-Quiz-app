import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/auth/usecases/login_user.dart';
import 'package:frontend/domain/auth/repositories/auth_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  group('LoginUser', () {
    late MockAuthRepository mockRepository;
    late LoginUser loginUser;

    setUp(() {
      mockRepository = MockAuthRepository();
      loginUser = LoginUser(mockRepository);
    });

    test('calls repository.login with correct arguments', () async {
      when(() => mockRepository.login(
        username: any(named: 'username'),
        password: any(named: 'password'),
        role: any(named: 'role'),
      )).thenAnswer((_) async => Future.value());

      await loginUser.call(
        username: 'testuser',
        password: 'pass123',
        role: 'admin',
      );

      verify(() => mockRepository.login(
        username: 'testuser',
        password: 'pass123',
        role: 'admin',
      )).called(1);
    });
  });
}
