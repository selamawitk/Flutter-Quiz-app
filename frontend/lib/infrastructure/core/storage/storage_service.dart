import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../config.dart';

class StorageService {
  late SharedPreferences _prefs;
  static final StorageService _instance = StorageService._internal();
  
  // Singleton pattern
  factory StorageService() => _instance;
  
  StorageService._internal();
  
  // Initialize shared preferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // Save auth token
  Future<bool> saveToken(String token) async {
    return await _prefs.setString(AppConfig.tokenKey, token);
  }
  
  // Get auth token
  String? getToken() {
    return _prefs.getString(AppConfig.tokenKey);
  }
  
  // Save user data
  Future<bool> saveUser(Map<String, dynamic> userData) async {
    return await _prefs.setString(AppConfig.userKey, jsonEncode(userData));
  }
  
  // Get user data
  Map<String, dynamic>? getUser() {
    final userJson = _prefs.getString(AppConfig.userKey);
    if (userJson != null) {
      return jsonDecode(userJson) as Map<String, dynamic>;
    }
    return null;
  }
  
  // Clear auth data
  Future<void> clearAuth() async {
    await _prefs.remove(AppConfig.tokenKey);
    await _prefs.remove(AppConfig.userKey);
  }
  
  // Clear all data
  Future<void> clearAll() async {
    await _prefs.clear();
  }
} 