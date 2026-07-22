import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../presentation/previous_exam/previous_exam_controller.dart';

class PreviousExamState {
  final String firstQuizId;
  final String secondQuizId;

  PreviousExamState({this.firstQuizId = '', this.secondQuizId = ''});

  PreviousExamState copyWith({String? firstQuizId, String? secondQuizId}) {
    return PreviousExamState(
      firstQuizId: firstQuizId ?? this.firstQuizId,
      secondQuizId: secondQuizId ?? this.secondQuizId,
    );
  }
}

final previousExamNotifierProvider = StateNotifierProvider<PreviousExamNotifier, PreviousExamState>((ref) {
  final controller = ref.watch(previousExamControllerProvider);
  return PreviousExamNotifier(controller: controller);
});

class PreviousExamNotifier extends StateNotifier<PreviousExamState> {
  final PreviousExamController _controller;

  PreviousExamNotifier({
    required PreviousExamController controller,
  })  : _controller = controller,
        super(PreviousExamState());

  void onFirstQuizIdChange(String id) {
    state = state.copyWith(firstQuizId: id);
  }

  void onSecondQuizIdChange(String id) {
    state = state.copyWith(secondQuizId: id);
  }

  void onViewClicked() {
    _controller.viewExam(state.firstQuizId);
  }

  void onContinueClicked() {
    _controller.continueExam(state.secondQuizId);
  }
}
