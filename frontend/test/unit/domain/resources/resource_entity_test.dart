import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/resources/entities/resource.dart';

void main() {
  test('should create Resource entity correctly', () {
    final resource = Resource(
      id: 'abc123',
      title: 'Flutter Guide',
      description: 'Learn Flutter',
      url: 'https://example.com/flutter.pdf',
    );

    expect(resource.id, 'abc123');
    expect(resource.title, 'Flutter Guide');
    expect(resource.description, 'Learn Flutter');
    expect(resource.url, 'https://example.com/flutter.pdf');
  });

  test('should support equality', () {
    final resource1 = Resource(
      id: '1',
      title: 'Title',
      description: 'Desc',
      url: 'https://x.com',
    );

    final resource2 = Resource(
      id: '1',
      title: 'Title',
      description: 'Desc',
      url: 'https://x.com',
    );

    expect(resource1, equals(resource2));
  });
}

