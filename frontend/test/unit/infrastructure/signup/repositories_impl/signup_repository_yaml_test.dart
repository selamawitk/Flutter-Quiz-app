import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:frontend/domain/signup/entities/signup_entity.dart';
import 'package:frontend/infrastructure/signup/repositories_yaml/signup_repository_yaml.dart';

void main() {
  late SignupRepositoryImpl repository;

  setUp(() {
    repository = SignupRepositoryImpl();
  });

  final testSignupData = SignupData(
    username: 'testuser',
    password: 'password123',
  );

  test('signup throws exception on network failure', () async {
    expect(() => repository.signup(testSignupData), throwsException);
  });
}
