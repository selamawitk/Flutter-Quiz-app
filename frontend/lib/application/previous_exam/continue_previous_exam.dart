import '../../domain/previous_exam/previous_exam.dart';
import '../../domain/previous_exam/previous_exam_repository.dart';

class ContinuePreviousExam {
  final PreviousExamRepository repository;

  ContinuePreviousExam(this.repository);

  Future<void> call(PreviousExam exam) => repository.continueExam(exam);
}
