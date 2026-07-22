import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/reset_password/entities/reset_password.dart';

void main() {
  group('ResetPassword Entity', () {
    const testResetPassword = ResetPassword(
      username: 'testuser',
      newPassword: 'newPassword123',
      confirmPassword: 'newPassword123',
      token: 'reset-token-123',
    );

    test('should be a subclass of Equatable', () {
      expect(testResetPassword, isA<ResetPassword>());
    });

    test('should return correct props for equality comparison', () {
      expect(
        testResetPassword.props,
        ['testuser', 'newPassword123', 'newPassword123', 'reset-token-123'],
      );
    });

    test('should create a copy with updated values', () {
      final updatedResetPassword = testResetPassword.copyWith(
        newPassword: 'updatedPassword123',
      );

      expect(updatedResetPassword.username, 'testuser');
      expect(updatedResetPassword.newPassword, 'updatedPassword123');
      expect(updatedResetPassword.confirmPassword, 'newPassword123');
      expect(updatedResetPassword.token, 'reset-token-123');
    });

    test('should convert to JSON correctly', () {
      final json = testResetPassword.toJson();

      expect(json, {
        'username': 'testuser',
        'newPassword': 'newPassword123',
        'confirmPassword': 'newPassword123',
        'token': 'reset-token-123',
      });
    });

    test('should create from JSON correctly', () {
      final json = {
        'username': 'testuser',
        'newPassword': 'newPassword123',
        'confirmPassword': 'newPassword123',
        'token': 'reset-token-123',
      };

      final resetPassword = ResetPassword.fromJson(json);

      expect(resetPassword, testResetPassword);
    });

    test('should handle null token in JSON conversion', () {
      const resetPasswordWithoutToken = ResetPassword(
        username: 'testuser',
        newPassword: 'password123',
        confirmPassword: 'password123',
      );

      final json = resetPasswordWithoutToken.toJson();

      expect(json, {
        'username': 'testuser',
        'newPassword': 'password123',
        'confirmPassword': 'password123',
      });
      expect(json.containsKey('token'), false);
    });
  });
} 