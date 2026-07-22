import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Simple class to mock
class Calculator {
  int add(int a, int b) => a + b;
  Future<int> addAsync(int a, int b) async => a + b;
}

// Mock implementation
class MockCalculator extends Mock implements Calculator {}

void main() {
  group('Mocktail Example Tests', () {
    late MockCalculator calculator;

    setUp(() {
      calculator = MockCalculator();
    });

    test('mocks synchronous method', () {
      // Arrange
      when(() => calculator.add(any(), any())).thenReturn(42);

      // Act
      final result = calculator.add(2, 3);

      // Assert
      expect(result, 42);
      verify(() => calculator.add(2, 3)).called(1);
    });

    test('mocks async method', () async {
      // Arrange
      when(() => calculator.addAsync(any(), any()))
          .thenAnswer((_) async => Future.value(42));

      // Act
      final result = await calculator.addAsync(2, 3);

      // Assert
      expect(result, 42);
      verify(() => calculator.addAsync(2, 3)).called(1);
    });
  });
}


