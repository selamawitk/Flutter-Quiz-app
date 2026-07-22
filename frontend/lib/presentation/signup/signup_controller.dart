import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/auth/auth_provider.dart';
import '../../domain/signup/entities/signup_entity.dart';
import '../../application/signup/usecases/signup_usecase.dart';
import '../../application/signup/signup_provider.dart';

class SignupController extends StateNotifier<SignupState> {
  final SignupUseCase signupUseCase;
  final Ref _ref;

  SignupController(this._ref, this.signupUseCase) : super(SignupState.initial());

  // String _email = '';
  String _username = '';
  String _password = '';

  // void setEmail(String value) => _email = value;
  void setUsername(String value) {
    state = state.copyWith(username: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  Future<bool> checkUsernameAvailability() async {
    if (state.username.isEmpty) {
      state = state.copyWith(errorMessage: 'የተጠቃሚ ስም ያስገቡ');
      return false;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final authController = _ref.read(authControllerProvider);
      final exists = await authController.checkUsernameExists(state.username);
      
      if (exists) {
        state = state.copyWith(isLoading: false, errorMessage: 'ይህ የተጠቃሚ ስም አስቀድሞ ተወስዷል');
        return false;
      } else {
        state = state.copyWith(isLoading: false, isUsernameValid: true);
        return true;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: 'የተጠቃሚ ስም መፈተሽ አልተሳካም');
      return false;
    }
  }

  Future<bool> validateAndProceed() async {
    if (state.username.isEmpty || state.password.isEmpty) {
      state = state.copyWith(errorMessage: 'ሁሉንም መረጃዎች ያስገቡ');
      return false;
    }

    if (state.password.length < 6) {
      state = state.copyWith(errorMessage: 'የይለፍ ቃል ቢያንስ 6 ፊደላት ያስፈልጋል');
      return false;
    }

    // Check username availability
    final isAvailable = await checkUsernameAvailability();
    if (isAvailable) {
      state = state.copyWith(isReadyForSecurityQuestions: true);
    }
    return isAvailable;
  }

  Future<bool> completeSignup(Map<String, String> securityAnswers) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // Register user with auth provider
      final authController = _ref.read(authControllerProvider);
      final success = await authController.register(state.username, state.password, 'student');
      
      if (success) {
        // Save security questions
        // In a real implementation, you'd save the security questions here
        state = state.copyWith(isLoading: false, isCompleted: true);
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

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

class SignupState {
  final String username;
  final String password;
  final bool isLoading;
  final bool isUsernameValid;
  final bool isReadyForSecurityQuestions;
  final bool isCompleted;
  final String? errorMessage;

  SignupState({
    required this.username,
    required this.password,
    required this.isLoading,
    required this.isUsernameValid,
    required this.isReadyForSecurityQuestions,
    required this.isCompleted,
    this.errorMessage,
  });

  factory SignupState.initial() {
    return SignupState(
      username: '',
      password: '',
      isLoading: false,
      isUsernameValid: false,
      isReadyForSecurityQuestions: false,
      isCompleted: false,
    );
  }

  SignupState copyWith({
    String? username,
    String? password,
    bool? isLoading,
    bool? isUsernameValid,
    bool? isReadyForSecurityQuestions,
    bool? isCompleted,
    String? errorMessage,
  }) {
    return SignupState(
      username: username ?? this.username,
      password: password ?? this.password,
      isLoading: isLoading ?? this.isLoading,
      isUsernameValid: isUsernameValid ?? this.isUsernameValid,
      isReadyForSecurityQuestions: isReadyForSecurityQuestions ?? this.isReadyForSecurityQuestions,
      isCompleted: isCompleted ?? this.isCompleted,
      errorMessage: errorMessage,
    );
  }
}

final signupControllerProvider = StateNotifierProvider<SignupController, SignupState>((ref) {
  final useCase = ref.read(signupUseCaseProvider);
  return SignupController(ref, useCase);
});
