import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/study/study_notifier.dart';
import '../../domain/study/entities/study_topic.dart';
import 'study_controller.dart';

// UI State specific to presentation layer
class StudyUIState {
  final bool isMenuOpen;
  final StudyTopic? selectedTopic;
  final bool showRetryButton;

  StudyUIState({
    this.isMenuOpen = false,
    this.selectedTopic,
    this.showRetryButton = false,
  });

  StudyUIState copyWith({
    bool? isMenuOpen,
    StudyTopic? selectedTopic,
    bool? showRetryButton,
  }) {
    return StudyUIState(
      isMenuOpen: isMenuOpen ?? this.isMenuOpen,
      selectedTopic: selectedTopic ?? this.selectedTopic,
      showRetryButton: showRetryButton ?? this.showRetryButton,
    );
  }
}

// UI Provider
final studyUIProvider = StateNotifierProvider<StudyUINotifier, StudyUIState>((ref) {
  return StudyUINotifier();
});

class StudyUINotifier extends StateNotifier<StudyUIState> {
  StudyUINotifier() : super(StudyUIState());

  void toggleMenu() {
    state = state.copyWith(isMenuOpen: !state.isMenuOpen);
  }

  void closeMenu() {
    state = state.copyWith(isMenuOpen: false);
  }

  void selectTopic(StudyTopic topic) {
    state = state.copyWith(selectedTopic: topic);
  }

  void showRetry() {
    state = state.copyWith(showRetryButton: true);
  }

  void hideRetry() {
    state = state.copyWith(showRetryButton: false);
  }
}

// Combined state provider that combines domain state with UI state
final combinedStudyStateProvider = Provider<CombinedStudyState>((ref) {
  final studyState = ref.watch(studyNotifierProvider);
  final uiState = ref.watch(studyUIProvider);
  
  return CombinedStudyState(
    topics: studyState.topics,
    isLoading: studyState.isLoading,
    error: studyState.error,
    isMenuOpen: uiState.isMenuOpen,
    selectedTopic: uiState.selectedTopic,
    showRetryButton: uiState.showRetryButton,
  );
});

class CombinedStudyState {
  final List<StudyTopic> topics;
  final bool isLoading;
  final String? error;
  final bool isMenuOpen;
  final StudyTopic? selectedTopic;
  final bool showRetryButton;

  CombinedStudyState({
    required this.topics,
    required this.isLoading,
    required this.error,
    required this.isMenuOpen,
    required this.selectedTopic,
    required this.showRetryButton,
  });
} 