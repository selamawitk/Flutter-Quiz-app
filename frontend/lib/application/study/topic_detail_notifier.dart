import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/study/entities/study_topic_detail.dart';
import '../../domain/study/usecases/get_study_topic_detail.dart';
import 'study_notifier.dart';

// State class for topic details
class TopicDetailState {
  final StudyTopicDetail? topicDetail;
  final bool isLoading;
  final String? error;

  TopicDetailState({
    this.topicDetail,
    this.isLoading = false,
    this.error,
  });

  TopicDetailState copyWith({
    StudyTopicDetail? topicDetail,
    bool? isLoading,
    String? error,
  }) {
    return TopicDetailState(
      topicDetail: topicDetail ?? this.topicDetail,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Providers for topic detail
final getStudyTopicDetailProvider = Provider<GetStudyTopicDetail>((ref) {
  final repository = ref.watch(studyRepositoryProvider);
  return GetStudyTopicDetail(repository);
});

final topicDetailNotifierProvider = StateNotifierProvider<TopicDetailNotifier, TopicDetailState>((ref) {
  final getStudyTopicDetail = ref.watch(getStudyTopicDetailProvider);
  return TopicDetailNotifier(getStudyTopicDetail);
});

// Notifier for topic details
class TopicDetailNotifier extends StateNotifier<TopicDetailState> {
  final GetStudyTopicDetail _getStudyTopicDetail;

  TopicDetailNotifier(this._getStudyTopicDetail) : super(TopicDetailState());

  Future<void> loadTopicDetail(String topicId) async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final topicDetail = await _getStudyTopicDetail.call(topicId);
      state = state.copyWith(
        topicDetail: topicDetail,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void clearState() {
    state = TopicDetailState();
  }
} 