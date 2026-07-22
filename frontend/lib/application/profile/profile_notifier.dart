import 'package:flutter/material.dart';

class ProfileNotifier extends ChangeNotifier {
  String name = 'User';
  bool isLoading = false;

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void logout() {
    // Add logout logic (e.g., clear session)
    print('Logged out');
    notifyListeners();
  }
}
