import '../../domain/previous_exam/previous_exam.dart';
import '../../domain/previous_exam/previous_exam_repository.dart';

class ViewPreviousExam {
  final PreviousExamRepository repository;

  ViewPreviousExam(this.repository);

  Future<void> call(PreviousExam exam) => repository.viewExam(exam);
}
