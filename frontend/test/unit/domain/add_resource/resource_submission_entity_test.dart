import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/add_resource/entities/resource.dart';

void main() {
  group('ResourceSubmission', () {
    test('should create a valid ResourceSubmission instance', () {
      const resource = ResourceSubmission(
        id: 'r1',
        title: 'Intro to AI',
        url: 'https://example.com/ai',
      );

      expect(resource.id, 'r1');
      expect(resource.title, 'Intro to AI');
      expect(resource.url, 'https://example.com/ai');
    });

    test('should support value equality', () {
      const r1 = ResourceSubmission(id: '1', title: 'T1', url: 'U1');
      const r2 = ResourceSubmission(id: '1', title: 'T1', url: 'U1');
      expect(r1, equals(r2));
    });
  });
}

