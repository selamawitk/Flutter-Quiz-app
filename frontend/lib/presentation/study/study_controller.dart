import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/study/entities/study_topic.dart';
import '../../application/study/study_notifier.dart';
import 'study_provider.dart';

class StudyController {
  final Ref ref;

  StudyController(this.ref);

  void onTopicSelected(StudyTopic topic, BuildContext context) {
    // Update UI state
    ref.read(studyUIProvider.notifier).selectTopic(topic);
    
    // Navigate to topic detail page using GoRouter
    GoRouter.of(context).go('/topic-detail', extra: {
      'topicId': topic.id,
      'topicTitle': topic.title,
      'topicAmharicTitle': topic.amharicTitle,
    });
  }

  void onBackPressed(BuildContext context) {
    // Close menu if open, otherwise navigate back to choice page
    final uiState = ref.read(studyUIProvider);
    if (uiState.isMenuOpen) {
      ref.read(studyUIProvider.notifier).closeMenu();
    } else {
      // Navigate back to choice page
      GoRouter.of(context).go('/choice');
    }
  }

  void onMenuToggle() {
    ref.read(studyUIProvider.notifier).toggleMenu();
  }

  void initializePage() {
    // Load study topics when page initializes
    ref.read(studyNotifierProvider.notifier).loadStudyTopics();
  }
}

final studyControllerProvider = Provider<StudyController>((ref) {
  return StudyController(ref);
}); 