import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/application/home/usecases/start_app.dart';

void main() {
  group('StartApp', () {
    test('should execute without throwing', () {
      final useCase = StartApp();

      expect(() => useCase.call(), returnsNormally);
    });
  });
}
