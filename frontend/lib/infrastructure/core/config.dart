class AppConfig {
  // API Base URL
  // Use 10.0.2.2 for Android emulator (points to host machine localhost)
  // Use localhost:3000 for web or iOS simulator
  // For production, set the actual server URL
  static const String apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:3000/api',
  );
  
  // Local Storage Keys
  static const String tokenKey = 'auth_token';
  static const String userKey = 'user_data';
  
  // Timeouts
  static const int connectionTimeout = 10; // seconds
  static const int receiveTimeout = 10; // seconds
  
  // Default Role
  static const String defaultRole = 'student';
}

// Used for device type detection
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

// Used for environment configuration
enum Environment {
  development,
  production,
  testing,
}

// Current environment
const Environment currentEnvironment = Environment.development;
