import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/category/entities/category.dart';

void main() {
  test('Category entity should be created with proper values', () {
    final category = Category(
      id: '1',
      name: 'Test Category',
      imageUrl: 'test_image.png',
      quizCount: 5,
    );

    expect(category.id, '1');
    expect(category.name, 'Test Category');
    expect(category.imageUrl, 'test_image.png');
    expect(category.quizCount, 5);
  });
}
