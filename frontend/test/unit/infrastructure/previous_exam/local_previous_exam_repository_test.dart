import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domain/previous_exam/previous_exam.dart';
import 'package:frontend/infrastructure/previous_exam/local_previous_exam_repository.dart';

void main() {
  late LocalPreviousExamDataSource dataSource;

  setUp(() {
    dataSource = LocalPreviousExamDataSource();
  });

  test('saveExam adds an exam to storage', () {
    final exam = PreviousExam(id: 'exam1');
    dataSource.saveExam(exam);

    expect(dataSource.getAllExams(), contains(exam));
  });

  test('getAllExams returns all saved exams', () {
    final exam1 = PreviousExam(id: '1');
    final exam2 = PreviousExam(id: '2');

    dataSource.saveExam(exam1);
    dataSource.saveExam(exam2);

    final result = dataSource.getAllExams();
    expect(result.length, 2);
    expect(result, containsAll([exam1, exam2]));
  });

  test('getExamById returns the correct exam if found', () {
    final exam = PreviousExam(id: 'xyz');
    dataSource.saveExam(exam);

    final result = dataSource.getExamById('xyz');
    expect(result?.id, 'xyz');
  });

  test('getExamById returns an empty exam if not found', () {
    final result = dataSource.getExamById('missing');
    expect(result?.id, '');
  });

  test('continueExam throws UnimplementedError', () {
    final exam = PreviousExam(id: '1');
    expect(() => dataSource.continueExam(exam), throwsUnimplementedError);
  });

  test('viewExam throws UnimplementedError', () {
    final exam = PreviousExam(id: '1');
    expect(() => dataSource.viewExam(exam), throwsUnimplementedError);
  });
}


