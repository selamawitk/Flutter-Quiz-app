import '../entities/study_topic_detail.dart';
import '../repositories/study_repository.dart';

class GetStudyTopicDetail {
  final StudyRepository repository;

  GetStudyTopicDetail(this.repository);

  Future<StudyTopicDetail> call(String topicId) async {
    if (topicId.isEmpty) {
      throw ArgumentError('Topic ID cannot be empty');
    }
    
    final topicDetail = await repository.getStudyTopicDetail(topicId);
    
    if (!topicDetail.isAvailable) {
      throw Exception('Topic is not available');
    }
    
    return topicDetail;
  }
} 