import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/forgot_password/entities/forgot_password.dart';

void main() {
  group('ForgotPassword Entity', () {
    final testDateTime = DateTime(2024, 1, 1, 12, 0, 0);
    final testForgotPassword = ForgotPassword(
      username: 'testuser',
      email: 'test@example.com',
      resetToken: 'reset-token-123',
      requestTime: testDateTime,
      isTokenValid: true,
    );

    test('should be a subclass of Equatable', () {
      expect(testForgotPassword, isA<ForgotPassword>());
    });

    test('should return correct props for equality comparison', () {
      expect(
        testForgotPassword.props,
        ['testuser', 'test@example.com', 'reset-token-123', testDateTime, true],
      );
    });

    test('should create a copy with updated values', () {
      final updatedForgotPassword = testForgotPassword.copyWith(
        email: 'updated@example.com',
        isTokenValid: false,
      );

      expect(updatedForgotPassword.username, 'testuser');
      expect(updatedForgotPassword.email, 'updated@example.com');
      expect(updatedForgotPassword.resetToken, 'reset-token-123');
      expect(updatedForgotPassword.requestTime, testDateTime);
      expect(updatedForgotPassword.isTokenValid, false);
    });

    test('should convert to JSON correctly', () {
      final json = testForgotPassword.toJson();

      expect(json, {
        'username': 'testuser',
        'email': 'test@example.com',
        'resetToken': 'reset-token-123',
        'requestTime': testDateTime.toIso8601String(),
        'isTokenValid': true,
      });
    });

    test('should create from JSON correctly', () {
      final json = {
        'username': 'testuser',
        'email': 'test@example.com',
        'resetToken': 'reset-token-123',
        'requestTime': testDateTime.toIso8601String(),
        'isTokenValid': true,
      };

      final forgotPassword = ForgotPassword.fromJson(json);

      expect(forgotPassword.username, testForgotPassword.username);
      expect(forgotPassword.email, testForgotPassword.email);
      expect(forgotPassword.resetToken, testForgotPassword.resetToken);
      expect(forgotPassword.requestTime, testForgotPassword.requestTime);
      expect(forgotPassword.isTokenValid, testForgotPassword.isTokenValid);
    });

    test('should handle null values in JSON conversion', () {
      const forgotPasswordMinimal = ForgotPassword(
        username: 'testuser',
      );

      final json = forgotPasswordMinimal.toJson();

      expect(json, {
        'username': 'testuser',
        'isTokenValid': false,
      });
      expect(json.containsKey('email'), false);
      expect(json.containsKey('resetToken'), false);
      expect(json.containsKey('requestTime'), false);
    });

    test('should create with default values', () {
      const forgotPassword = ForgotPassword(username: 'testuser');

      expect(forgotPassword.username, 'testuser');
      expect(forgotPassword.email, null);
      expect(forgotPassword.resetToken, null);
      expect(forgotPassword.requestTime, null);
      expect(forgotPassword.isTokenValid, false);
    });
  });
} 