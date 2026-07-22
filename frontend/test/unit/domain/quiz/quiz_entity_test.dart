import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/result/entities/result.dart';

void main() {
  group('Result Entity', () {
    test('should create a Result with id, title, score, and total', () {
      final result = Result(
        id: 'r1',
        title: 'Sample Result',
        score: 8,
        total: 10,
      );

      expect(result.id, 'r1');
      expect(result.title, 'Sample Result');
      expect(result.score, 8);
      expect(result.total, 10);
    });
  });
}
