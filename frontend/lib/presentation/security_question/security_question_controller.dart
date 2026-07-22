import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/auth/auth_provider.dart';

class SecurityQuestionController extends StateNotifier<SecurityQuestionState> {
  final Ref _ref;

  SecurityQuestionController(this._ref) : super(SecurityQuestionState.initial());

  void setQuestion1(String value) {
    state = state.copyWith(question1: value);
  }

  void setAnswer1(String value) {
    state = state.copyWith(answer1: value);
  }

  void setQuestion2(String value) {
    state = state.copyWith(question2: value);
  }

  void setAnswer2(String value) {
    state = state.copyWith(answer2: value);
  }

  Future<bool> submitAnswers() async {
    if (!_validateInputs()) {
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // For forgot password flow - just validate all fields are filled
      await Future.delayed(Duration(milliseconds: 500)); // Simulate API call
      state = state.copyWith(isLoading: false, isSubmitted: true);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'ጥያቄዎች ማስቀመጥ አልተሳካም');
      return false;
    }
  }

  Future<bool> submitAnswersForSignup(String username, String password, Map<String, String> securityAnswers) async {
    if (!_validateInputs()) {
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Register user with auth provider
      final authController = _ref.read(authControllerProvider);
      final success = await authController.register(username, password, 'student');
      
      if (success) {
        // Save security questions (in a real implementation)
        // Here you would call the API to save security questions
        state = state.copyWith(isLoading: false, isSubmitted: true);
        return true;
      } else {
        state = state.copyWith(isLoading: false, errorMessage: 'መመዝገብ አልተሳካም');
        return false;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  bool _validateInputs() {
    if (state.question1.isEmpty || state.answer1.isEmpty || 
        state.question2.isEmpty || state.answer2.isEmpty) {
      state = state.copyWith(errorMessage: 'ሁሉንም ጥያቄዎች እና መልሶች ያስገቡ');
      return false;
    }
    return true;
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

class SecurityQuestionState {
  final String question1;
  final String answer1;
  final String question2;
  final String answer2;
  final bool isLoading;
  final bool isSubmitted;
  final String? errorMessage;

  SecurityQuestionState({
    required this.question1,
    required this.answer1,
    required this.question2,
    required this.answer2,
    required this.isLoading,
    required this.isSubmitted,
    this.errorMessage,
  });

  factory SecurityQuestionState.initial() {
    return SecurityQuestionState(
      question1: '',
      answer1: '',
      question2: '',
      answer2: '',
      isLoading: false,
      isSubmitted: false,
    );
  }

  SecurityQuestionState copyWith({
    String? question1,
    String? answer1,
    String? question2,
    String? answer2,
    bool? isLoading,
    bool? isSubmitted,
    String? errorMessage,
  }) {
    return SecurityQuestionState(
      question1: question1 ?? this.question1,
      answer1: answer1 ?? this.answer1,
      question2: question2 ?? this.question2,
      answer2: answer2 ?? this.answer2,
      isLoading: isLoading ?? this.isLoading,
      isSubmitted: isSubmitted ?? this.isSubmitted,
      errorMessage: errorMessage,
    );
  }
}

final securityQuestionControllerProvider = StateNotifierProvider<SecurityQuestionController, SecurityQuestionState>((ref) {
  return SecurityQuestionController(ref);
});
