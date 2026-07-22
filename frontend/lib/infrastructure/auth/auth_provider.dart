import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_service.dart';
import '../core/storage/storage_service.dart';

// Provider for StorageService
final storageServiceProvider = Provider<StorageService>((ref) {
  return StorageService();
});

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Provider for storing the authentication state
final authStateProvider = StateProvider<AuthState>((ref) {
  return AuthState.initial();
});

// Class to represent authentication state
class AuthState {
  final bool isAuthenticated;
  final String token;
  final Map<String, dynamic>? user;
  final String? errorMessage;

  AuthState({
    required this.isAuthenticated,
    required this.token,
    this.user,
    this.errorMessage,
  });

  factory AuthState.initial() {
    return AuthState(
      isAuthenticated: false,
      token: '',
    );
  }

  factory AuthState.authenticated(String token, Map<String, dynamic> user) {
    return AuthState(
      isAuthenticated: true,
      token: token,
      user: user,
    );
  }

  factory AuthState.error(String message) {
    return AuthState(
      isAuthenticated: false,
      token: '',
      errorMessage: message,
    );
  }

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    Map<String, dynamic>? user,
    String? errorMessage,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

// Provider to handle authentication actions
final authControllerProvider = Provider((ref) => AuthController(ref));

class AuthController {
  final Ref _ref;

  AuthController(this._ref);

  // Initialize authentication state from storage
  Future<void> initAuth() async {
    final storageService = _ref.read(storageServiceProvider);
    await storageService.init();
    
    final token = storageService.getToken();
    final userData = storageService.getUser();
    
    if (token != null && userData != null) {
      // Set token in HTTP client
      final authService = _ref.read(authServiceProvider);
      authService.setToken(token);
      
      // Update auth state
      _ref.read(authStateProvider.notifier).state = AuthState.authenticated(
        token,
        userData,
      );
    }
  }

  // Login user
  Future<bool> login(String username, String password, String role) async {
    try {
      final authService = _ref.read(authServiceProvider);
      final response = await authService.login(username, password, role);
      
      final token = response['token'];
      final userData = response['user'];
      
      // Save to storage
      final storageService = _ref.read(storageServiceProvider);
      await storageService.saveToken(token);
      await storageService.saveUser(userData);
      
      // Update state
      _ref.read(authStateProvider.notifier).state = AuthState.authenticated(
        token,
        userData,
      );
      
      return true;
    } catch (e) {
      _ref.read(authStateProvider.notifier).state = AuthState.error(e.toString());
      return false;
    }
  }

  // Register user
  Future<bool> register(String username, String password, String role) async {
    try {
      final authService = _ref.read(authServiceProvider);
      final response = await authService.register(username, password, role);
      
      final token = response['token'];
      final userData = response['user'];
      
      // Save to storage
      final storageService = _ref.read(storageServiceProvider);
      await storageService.saveToken(token);
      await storageService.saveUser(userData);
      
      // Update state
      _ref.read(authStateProvider.notifier).state = AuthState.authenticated(
        token,
        userData,
      );
      
      return true;
    } catch (e) {
      _ref.read(authStateProvider.notifier).state = AuthState.error(e.toString());
      return false;
    }
  }

  // Logout
  Future<void> logout() async {
    final authService = _ref.read(authServiceProvider);
    authService.logout();
    
    // Clear storage
    final storageService = _ref.read(storageServiceProvider);
    await storageService.clearAuth();
    
    // Update state
    _ref.read(authStateProvider.notifier).state = AuthState.initial();
  }

  // Check if username exists
  Future<bool> checkUsernameExists(String username) async {
    try {
      final authService = _ref.read(authServiceProvider);
      return await authService.checkUsernameExists(username);
    } catch (e) {
      _ref.read(authStateProvider.notifier).state = AuthState.error(e.toString());
      return false;
    }
  }

  // Get security questions
  Future<Map<String, String>> getSecurityQuestions(String username) async {
    try {
      final authService = _ref.read(authServiceProvider);
      return await authService.getSecurityQuestions(username);
    } catch (e) {
      _ref.read(authStateProvider.notifier).state = AuthState.error(e.toString());
      return {};
    }
  }

  // Verify security answers
  Future<String> verifySecurityAnswers(String username, Map<String, String> answers) async {
    try {
      final authService = _ref.read(authServiceProvider);
      return await authService.verifySecurityAnswers(username, answers);
    } catch (e) {
      _ref.read(authStateProvider.notifier).state = AuthState.error(e.toString());
      return '';
    }
  }

  // Reset password
  Future<bool> resetPassword(String username, String newPassword, String resetToken) async {
    try {
      final authService = _ref.read(authServiceProvider);
      return await authService.resetPassword(username, newPassword, resetToken);
    } catch (e) {
      _ref.read(authStateProvider.notifier).state = AuthState.error(e.toString());
      return false;
    }
  }

  // Get current user
  Future<Map<String, dynamic>?> getCurrentUser() async {
    try {
      final authService = _ref.read(authServiceProvider);
      final user = await authService.getCurrentUser();
      
      // Update user in state and storage
      final currentState = _ref.read(authStateProvider);
      _ref.read(authStateProvider.notifier).state = currentState.copyWith(user: user);
      
      final storageService = _ref.read(storageServiceProvider);
      await storageService.saveUser(user);
      
      return user;
    } catch (e) {
      return null;
    }
  }
} 