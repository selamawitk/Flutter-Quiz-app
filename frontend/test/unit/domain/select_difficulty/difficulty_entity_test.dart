import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/select_difficulty/entities/difficulty.dart';

void main() {
  group('Difficulty Entity', () {
    test('should support equality', () {
      final difficulty1 = Difficulty(label: 'Easy');
      final difficulty2 = Difficulty(label: 'Easy');
      final difficulty3 = Difficulty(label: 'Hard');

      expect(difficulty1, equals(difficulty2));
      expect(difficulty1 == difficulty3, isFalse);
    });

    test('should have correct string representation', () {
      final difficulty = Difficulty(label: 'Medium');
      expect(difficulty.toString(), 'Difficulty(label: Medium)');
    });

    test('should create Difficulty with non-empty label', () {
      final difficulty = Difficulty(label: 'Hard');
      expect(difficulty.label, 'Hard');
    });
  });
}

