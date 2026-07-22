import 'package:frontend/infrastructure/previous_exam/local_previous_exam_repository.dart';

import '../../domain/previous_exam/previous_exam.dart';
import '../../domain/previous_exam/previous_exam_repository.dart';

class PreviousExamRepositoryImpl implements PreviousExamRepository {
  final LocalPreviousExamDataSource localDataSource;

  PreviousExamRepositoryImpl(this.localDataSource);

  @override
  Future<void> viewExam(PreviousExam exam) async {
    print("Viewing exam: ${exam.id}");
    localDataSource.getExamById(exam.id);
  }

  @override
  Future<void> continueExam(PreviousExam exam) async {
    print("Continuing exam: ${exam.id}");
    localDataSource.getExamById(exam.id);
  }
}
