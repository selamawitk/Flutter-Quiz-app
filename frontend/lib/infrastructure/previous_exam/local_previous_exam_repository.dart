import '../../domain/previous_exam/previous_exam_repository.dart';
import '../../domain/previous_exam/previous_exam.dart';

class LocalPreviousExamDataSource implements PreviousExamRepository {
  final List<PreviousExam> _examStorage = [];

  void saveExam(PreviousExam exam) {
    _examStorage.add(exam);
  }

  List<PreviousExam> getAllExams() {
    return _examStorage;
  }

  PreviousExam? getExamById(String id) {
    if (id.isEmpty) return null;
    return _examStorage.firstWhere(
      (e) => e.id == id,
      orElse: () => PreviousExam(id: ''),
    );
  }

  @override
  Future<void> continueExam(PreviousExam exam) async {
    // In-memory: exam is already stored, nothing to do
  }

  @override
  Future<void> viewExam(PreviousExam exam) async {
    // In-memory: exam is already stored, nothing to do
  }
}
