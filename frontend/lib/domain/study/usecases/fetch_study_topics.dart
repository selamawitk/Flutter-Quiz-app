import '../entities/study_topic.dart';
import '../repositories/study_repository.dart';

class FetchStudyTopics {
  final StudyRepository repository;

  FetchStudyTopics(this.repository);

  Future<List<StudyTopic>> call() async {
    final allTopics = await repository.fetchStudyTopics();
    // Only return topics that are available
    return allTopics.where((topic) => topic.isAvailable).toList();
  }
} 