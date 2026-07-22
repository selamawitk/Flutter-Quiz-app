import 'package:frontend/domain/previous_exam/previous_exam.dart';

abstract class PreviousExamRepository {
  Future<void> viewExam(PreviousExam exam);
  Future<void> continueExam(PreviousExam exam);
}
