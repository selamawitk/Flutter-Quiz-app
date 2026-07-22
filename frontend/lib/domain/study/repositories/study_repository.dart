import '../entities/study_topic.dart';
import '../entities/study_topic_detail.dart';

abstract class StudyRepository {
  Future<List<StudyTopic>> fetchStudyTopics();
  Future<StudyTopic> getStudyTopicById(String id);
  Future<StudyTopicDetail> getStudyTopicDetail(String id);
} 