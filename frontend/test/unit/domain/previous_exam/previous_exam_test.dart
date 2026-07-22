import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/previous_exam/previous_exam.dart';

void main() {
  test('PreviousExam initializes with the correct id', () {
    final exam = PreviousExam(id: '12345');

    expect(exam.id, '12345');
  });
}

