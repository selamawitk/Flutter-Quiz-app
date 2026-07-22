import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/infrastructure/quiz/repositories_impl/quiz_repository_impl.dart';

void main() {
  group('QuizRepositoryImpl', () {
    test('should be instantiable', () {
      final repository = QuizRepositoryImpl();
      expect(repository, isA<dynamic>());
    });
  });
}
