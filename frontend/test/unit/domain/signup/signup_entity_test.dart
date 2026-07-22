import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/signup/entities/signup_entity.dart';

void main() {
  group('SignupData', () {
    test('should correctly create SignupData with given username and password', () {
      final signupData = SignupData(
        username: 'testuser',
        password: 'securePass123',
      );

      expect(signupData.username, equals('testuser'));
      expect(signupData.password, equals('securePass123'));
    });
  });
}
