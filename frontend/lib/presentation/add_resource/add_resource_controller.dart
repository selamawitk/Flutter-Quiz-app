import 'package:flutter_riverpod/flutter_riverpod.dart';

final addResourceControllerProvider =
StateNotifierProvider<AddResourceController, AddResourceState>((ref) {
  return AddResourceController();
});

class AddResourceState {
  final String topic;
  final String detail;

  AddResourceState({
    this.topic = '',
    this.detail = '',
  });

  AddResourceState copyWith({String? topic, String? detail}) {
    return AddResourceState(
      topic: topic ?? this.topic,
      detail: detail ?? this.detail,
    );
  }
}

class ResourceModel {
  final String topic;
  final String detail;

  ResourceModel({required this.topic, required this.detail});
}

class AddResourceController extends StateNotifier<AddResourceState> {
  AddResourceController() : super(AddResourceState());

  final List<ResourceModel> _resources = [];

  List<ResourceModel> get resources => _resources;

  void setTopic(String topic) {
    state = state.copyWith(topic: topic);
  }

  void setDetail(String detail) {
    state = state.copyWith(detail: detail);
  }

  void submit() {
    if (state.topic.trim().isEmpty || state.detail.trim().isEmpty) return;

    final newResource = ResourceModel(
      topic: state.topic.trim(),
      detail: state.detail.trim(),
    );

    _resources.add(newResource);

    // Clear form after submission
    state = AddResourceState();
  }
}
