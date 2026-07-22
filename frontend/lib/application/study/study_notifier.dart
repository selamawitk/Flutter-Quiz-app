import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/study/entities/study_topic.dart';
import '../../domain/study/usecases/fetch_study_topics.dart';
import '../../infrastructure/study/datasources/study_remote_data_source.dart';
import '../../infrastructure/study/repositories_impl/study_repository_impl.dart';

// State class
class StudyState {
  final List<StudyTopic> topics;
  final bool isLoading;
  final String? error;

  StudyState({
    this.topics = const [],
    this.isLoading = false,
    this.error,
  });

  StudyState copyWith({
    List<StudyTopic>? topics,
    bool? isLoading,
    String? error,
  }) {
    return StudyState(
      topics: topics ?? this.topics,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Providers
final studyRemoteDataSourceProvider = Provider<StudyRemoteDataSource>((ref) {
  return StudyRemoteDataSourceImpl();
});

final studyRepositoryProvider = Provider<StudyRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(studyRemoteDataSourceProvider);
  return StudyRepositoryImpl(remoteDataSource);
});

final fetchStudyTopicsProvider = Provider<FetchStudyTopics>((ref) {
  final repository = ref.watch(studyRepositoryProvider);
  return FetchStudyTopics(repository);
});

final studyNotifierProvider = StateNotifierProvider<StudyNotifier, StudyState>((ref) {
  final fetchStudyTopics = ref.watch(fetchStudyTopicsProvider);
  return StudyNotifier(fetchStudyTopics);
});

// Notifier
class StudyNotifier extends StateNotifier<StudyState> {
  final FetchStudyTopics _fetchStudyTopics;

  StudyNotifier(this._fetchStudyTopics) : super(StudyState());

  Future<void> loadStudyTopics() async {
    state = state.copyWith(isLoading: true, error: null);
    
    try {
      final topics = await _fetchStudyTopics.call();
      state = state.copyWith(
        topics: topics,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  void selectTopic(StudyTopic topic) {
    // Handle topic selection - could navigate to topic details
    print('Selected topic: ${topic.title}');
  }
} 