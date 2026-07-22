import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/study/topic_detail_notifier.dart';

class TopicDetailController {
  final Ref ref;

  TopicDetailController(this.ref);

  void initializePage(String topicId) {
    ref.read(topicDetailNotifierProvider.notifier).loadTopicDetail(topicId);
  }

  void onBackPressed() {
    ref.read(topicDetailNotifierProvider.notifier).clearState();
  }

  void onRetryPressed(String topicId) {
    ref.read(topicDetailNotifierProvider.notifier).loadTopicDetail(topicId);
  }

  void onMenuToggle() {
    // Menu toggle functionality (if needed)
  }
}

final topicDetailControllerProvider = Provider<TopicDetailController>((ref) {
  return TopicDetailController(ref);
}); 