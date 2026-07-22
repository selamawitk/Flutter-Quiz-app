import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../infrastructure/auth/auth_provider.dart';

class LoginController extends StateNotifier<LoginState> {
  final Ref _ref;

  LoginController(this._ref) : super(LoginState.initial());

  void setUsername(String value) {
    state = state.copyWith(username: value);
  }

  void setPassword(String value) {
    state = state.copyWith(password: value);
  }

  void setRole(String value) {
    state = state.copyWith(role: value);
  }

  Future<Map<String, dynamic>?> login() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final authController = _ref.read(authControllerProvider);
      final success = await authController.login(
        state.username,
        state.password,
        state.role.isEmpty ? 'student' : state.role, // Default to student if role not selected
      );
      
      if (success) {
        // Get the authenticated user data including role
        final authState = _ref.read(authStateProvider);
        final userData = authState.user;
        
        state = state.copyWith(isLoading: false, isAuthenticated: true, userData: userData);
        return userData;
      } else {
        state = state.copyWith(isLoading: false, errorMessage: 'Invalid credentials');
        return null;
      }
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return null;
    }
  }
}

class LoginState {
  final String username;
  final String password;
  final String role;
  final bool isLoading;
  final bool isAuthenticated;
  final String? errorMessage;
  final Map<String, dynamic>? userData;

  LoginState({
    required this.username,
    required this.password,
    required this.role,
    required this.isLoading,
    required this.isAuthenticated,
    this.errorMessage,
    this.userData,
  });

  factory LoginState.initial() {
    return LoginState(
      username: '',
      password: '',
      role: 'student', // Default role
      isLoading: false,
      isAuthenticated: false,
    );
  }

  LoginState copyWith({
    String? username,
    String? password,
    String? role,
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage,
    Map<String, dynamic>? userData,
  }) {
    return LoginState(
      username: username ?? this.username,
      password: password ?? this.password,
      role: role ?? this.role,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage,
      userData: userData ?? this.userData,
    );
  }
}

final loginControllerProvider = StateNotifierProvider<LoginController, LoginState>(
  (ref) => LoginController(ref),
);
