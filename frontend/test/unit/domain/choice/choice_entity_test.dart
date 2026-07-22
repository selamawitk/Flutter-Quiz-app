import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/choice/entities/choice.dart';

void main() {
  group('Choice', () {
    test('should correctly instantiate with id and name', () {
      final choice = Choice(id: '1', name: 'Option A');

      expect(choice.id, equals('1'));
      expect(choice.name, equals('Option A'));
    });
  });
}
