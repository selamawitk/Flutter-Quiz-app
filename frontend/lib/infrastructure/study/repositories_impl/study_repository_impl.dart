import '../../../domain/study/entities/study_topic.dart';
import '../../../domain/study/entities/study_topic_detail.dart';
import '../../../domain/study/repositories/study_repository.dart';
import '../datasources/study_remote_data_source.dart';

class StudyRepositoryImpl implements StudyRepository {
  final StudyRemoteDataSource remoteDataSource;

  StudyRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<StudyTopic>> fetchStudyTopics() {
    return remoteDataSource.getStudyTopics();
  }

  @override
  Future<StudyTopic> getStudyTopicById(String id) async {
    final topics = await remoteDataSource.getStudyTopics();
    return topics.firstWhere(
      (topic) => topic.id == id,
      orElse: () => throw Exception('Study topic not found'),
    );
  }

  @override
  Future<StudyTopicDetail> getStudyTopicDetail(String id) {
    return remoteDataSource.getStudyTopicDetail(id);
  }
} 